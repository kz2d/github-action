# !/bin/bash

LAST_TAG=$(git tag -l | tac | head -n1)  
# git checkout $LAST_TAG
HASH=$(git show -s --format='%h' ${LAST_TAG})

docker build . -t "$LAST_TAG/$HASH"
IS_DONE=$(echo $?)
COMMENT="docker build complited:\n   tag:$LAST_TAG/$HASH\n   exitcode:$IS_DONE"

./.github/scripts/utils/addTrackerComment.sh $COMMENT