# !/bin/bash

LAST_TAG=$(git tag -l | tac | head -n1)  
PREV_TAG=$(git tag -l | tac |tail -n +2| head -n1  )  
AUTHOR=$(git show -s --format='%an' ${LAST_TAG})
DATE=$(git show -s --format='%cd' ${LAST_TAG})
CHANGELOG=$(git log ${PREV_TAG}..${LAST_TAG} --pretty=format:"%h - %s, %ad\n"  | tr -s "\n" " " )
SUMMARY="Realis for ${LAST_TAG} in "
UNIQUE="$REPO_NAME/$LAST_TAG"
#TODO ${CHANGELOG}
DESCRIPTION=" ${LAST_TAG}\n ${AUTHOR}\n${DATE}\nchangelog:\n$CHANGELOG"
echo $SUMMARY
echo $DESCRIPTION
echo $UNIQUE
 
./.github/scripts/utils/createTrackerTask.sh "$SUMMARY" "$DESCRIPTION" "$UNIQUE"

