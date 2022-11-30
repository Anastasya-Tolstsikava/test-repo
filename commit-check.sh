#!/bin/bash

CHANGED=$(git diff origin/main...HEAD --name-only)
CHANGELOG_IN_MASTER=$(git show origin/main:CHANGELOG.md)
THIRD_ROW=$(head -3 CHANGELOG.md | tail -1)
THIRD_ROW_IN_MASTER=$(echo "${CHANGELOG_IN_MASTER}" | head -3 | tail -1)

if [[ "$CHANGED" == *"CHANGELOG.md"* ]]; then
  echo "${THIRD_ROW}"
  echo "${THIRD_ROW_IN_MASTER}"
  LAST_VERSION_IN_MASTER=${THIRD_ROW_IN_MASTER#* }
  LAST_VERSION_IN_MASTER=${LAST_VERSION_IN_MASTER% *}

  NEW_VERSION_FROM_BRANCH=${THIRD_ROW#* }
  NEW_VERSION_FROM_BRANCH=${NEW_VERSION_FROM_BRANCH% *}

  echo "${LAST_VERSION_IN_MASTER}"
  echo "${NEW_VERSION_FROM_BRANCH}"
  if [[ NEW_VERSION_FROM_BRANCH > LAST_VERSION_IN_MASTER ]]; then
      # doesn't work for versions because it is not the number. Requires more complicated comparing logic.
      echo "Great! version number is bigger than in master."
  else
    echo "New version number in CHANGELOG.md file need to be grater than the latest in master branch."
    exit 1
  fi
else
  echo "CHANGELOG.md file need to be updated."
  exit 1
fi
#echo "${CHANGED}"
#echo "${CHANGELOG_IN_MASTER}"
#echo "${THIRD_ROW}"
exit 0
