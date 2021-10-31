# !/bin/bash

echo $1
echo $2
echo $3
RESPONSE=$(curl -X POST https://api.tracker.yandex.net/v2/issues/ \
    -H "Authorization: OAuth AQAAAABG5oZkAAd4-c20vI6vNUd_sYRnDm2DSvU" \
    -H "X-Org-ID: 6461097" \
    -H "Content-Type: application/json" \
    --data-raw '{
    "summary": "'"$1"'",
    "description": "'"$2"'",
    "unique": "'"$3"'",
    "queue": "TMP"
}'|  ./.github/scripts/utils/jq -r ".statusCode")
echo $RESPONSE
if [ $RESPONSE = 201 ]; then
  echo "ticket created "
  exit 0
elif [ $RESPONSE = 404 ]; then
  echo "wrong user oAuth"
  exit 1
elif [ $RESPONSE = 409 ]; then
  echo "Ticket already exists"

  RESPONSE=$(curl -X POST https://api.tracker.yandex.net/v2/issues/_search \
    -H "Authorization: OAuth AQAAAABG5oZkAAd4-c20vI6vNUd_sYRnDm2DSvU" \
    -H "X-Org-ID: 6461097" \
    -H "Content-Type: application/json" \
    --data-raw '{"filter":{"unique":"lol"}}' |  ./.github/scripts/utils/jq -r '.[].key')
    echo $RESPONSE


  UPDATE_RESPONSE=$(
    curl -X PATCH "https://api.tracker.yandex.net/v2/issues/$RESPONSE"  \
    -H "Authorization: OAuth AQAAAABG5oZkAAd4-c20vI6vNUd_sYRnDm2DSvU" \
    -H "X-Org-ID: 6461097" \
    -H "Content-Type: application/json" \
    --data-raw '{
        "summary": "'"2"'",
    "description": "'"2"'"
     }')

UPDATE_RESPONSE_CODE=$(echo $UPDATE_RESPONSE|./.github/scripts/utils/jq -r ".statusCode" )


    if [ ${UPDATE_RESPONSE_CODE} = 200 ]; then
      echo "ticket created"
      exit 0
    elif [ ${UPDATE_RESPONSE_CODE} = 404 ]; then
      echo "wrong user oAuth"
      exit 1
    else 
      echo "Something went wrong ${UPDATE_RESPONSE}"
      exit 1
    fi
fi
