# !/bin/bash

LAST_TAG=$(git tag -l | tac | head -n1)  
git checkout $LAST_TAG
npm run build

CI=true
npm test 2>yourfile.txt
IS_DONE=$(echo $?)
TEST_HISTORY=$(awk '{printf "%s\\n", $0}' yourfile.txt)
TEST_HISTORY="test complited:\n$TEST_HISTORY"
echo $IS_DONE
echo $TEST_HISTORY 

./.github/scripts/utils/addTrackerComment.sh "$TEST_HISTORY"



