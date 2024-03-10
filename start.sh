#!/usr/bin/env bash
source .env

while true
do
	echo "$(date) Downloading"
	audible download --all --aax-fallback --output-dir /downloads

	echo "$(date) Converting"
	./convert.sh

	echo "$(date) Sleeping for ${LOOP_DURATION} seconds"
	sleep "${LOOP_DURATION}"
done

