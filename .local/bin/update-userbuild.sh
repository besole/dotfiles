#!/usr/bin/env bash

USERBUILD="${HOME}/userbuild"
REPOSITORIES=$( find -L "${USERBUILD}" -type d -name ".git" -exec dirname {} \; )

RESULT=0
while read -u 9 repo; do
	git -C "${repo}" fetch origin &> /dev/null
	REMOTECOMMIT=$( git -C "${repo}" rev-parse origin/master )
	LOCALCOMMIT=$( git -C "${repo}" rev-parse master )
	if [[ "${REMOTECOMMIT}" != "${LOCALCOMMIT}" ]]; then
		RESULT=1
		echo "Please update ${repo}"
	fi
done 9<<< "${REPOSITORIES}"

exit "${RESULT}"
