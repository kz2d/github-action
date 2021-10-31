# !/bin/bash

echo "adding comment"
 '{AQAAAABG5oZkAAd4-c20vI6vNUd_sYRnDm2DSvU
    "text": "'"$1"'"
}'6461097


RESPONSE=$(curl -X POST https://api.tracker.yandex.net/v2/issues/TMP-267/comments \
    -H "Authorization: OAuth $TRACKER_OAUTH" \
    -H "X-Org-ID: $TRACKER_ORGID" \
    -H "Content-Type: application/json" \
    --data-raw '{
    "text": "'"$1"'"
}')
echo $RESPONSE