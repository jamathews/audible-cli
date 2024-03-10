#!/usr/bin/env bash
source .env

cd /downloads

while true
do
	echo "$(date) Downloading"
	audible download --all --aax-fallback --jobs 8 --output-dir /downloads

	echo "$(date) Converting"
	/audible-cli/convert.sh

	echo "$(date) Sleeping for ${LOOP_DURATION} seconds"
	sleep "${LOOP_DURATION}"
done

