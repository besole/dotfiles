#!/usr/bin/env bash

USERBUILD="${HOME}/userbuild"
REPOSITORIES=$( find -L "${USERBUILD}" -type d -name ".git" -exec dirname {} \; )

RESULT=0
while read -r repo; do
	(
		git -C "${repo}" fetch --all &> /dev/null
		REMOTECOMMIT=$( git -C "${repo}" rev-parse "HEAD@{upstream}" )
		LOCALCOMMIT=$( git -C "${repo}" rev-parse "HEAD" )
		if [[ "${REMOTECOMMIT}" != "${LOCALCOMMIT}" ]]; then
			RESULT=1
			echo "Please update ${repo}"
		fi
	) &
done <<< "${REPOSITORIES}"

wait $(jobs -p)
exit "${RESULT}"
