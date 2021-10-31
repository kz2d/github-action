# !/bin/bash

echo "adding comment"


TRACKER_ID=$(curl -X POST https://api.tracker.yandex.net/v2/issues/_search \
    -H "Authorization: OAuth $TRACKER_OAUTH" \
    -H "X-Org-ID: $TRACKER_ORGID" \
    -H "Content-Type: application/json" \
    --data-raw '{"filter":{"unique":"lol"}}' |  ./.github/scripts/utils/jq -r '.[].key')
    echo $TRACKER_ID

RESPONSE=$(curl -X POST "https://api.tracker.yandex.net/v2/issues/${TRACKER_ID}/comments" \
    -H "Authorization: OAuth AQAAAABG5oZkAAd4-c20vI6vNUd_sYRnDm2DSvU" \
    -H "X-Org-ID: 6461097" \
    -H "Content-Type: application/json" \
    --data-raw '{"text":"test complited:\n FAIL  test/exemple.test.js\n  ● Simple Test Case › Should return 4\n\n    expect(received).toBe(expected) // Object.is equality\n\n    Expected: 4\n    Received: 3\n\n      3 |     if (Math.random() > 0);\n      4 |\n    > 5 |     expect(2 + 1).toBe(4);\n        |                   ^\n      6 |   });\n      7 | });\n      8 |\n\n      at Object.<anonymous> (test/exemple.test.js:5:19)\n\n PASS  test/compile.test.js\n\nTest Suites: 1 failed, 1 passed, 2 total\nTests:       1 failed, 1 passed, 2 total\nSnapshots:   0 total\nTime:        0.447 s, estimated 1 s\nRan all test suites.\n"}'
    )
echo $RESPONSE