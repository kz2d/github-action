# !/bin/bash

echo "adding comment"

LAST_TAG=$(git tag -l | tac | head -n1)  

TRACKER_ID=$(curl -X POST https://api.tracker.yandex.net/v2/issues/_search \
    -H "Authorization: OAuth $TRACKER_OAUTH" \
    -H "X-Org-ID: $TRACKER_ORGID" \
    -H "Content-Type: application/json" \
    --data-raw '{"filter":{"unique":"'"$REPO_NAME/$LAST_TAG"'"}}' |  ./.github/scripts/utils/jq -r '.[].key')
    echo $TRACKER_ID

RESPONSE=$(curl -X POST "https://api.tracker.yandex.net/v2/issues/${TRACKER_ID}/comments" \
    -H "Authorization: OAuth $TRACKER_OAUTH" \
    -H "X-Org-ID: $TRACKER_ORGID" \
    -H "Content-Type: application/json" \
    --data-raw '{"text":"'"$1"'"}'
    )
echo $RESPONSE