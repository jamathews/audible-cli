#!/usr/bin/env bash
source .env

while true
do
	echo "$(date) Downloading"
	audible download --aax-fallback --output-dir /downloads

	echo "$(date) Converting"
	./convert.sh

	sleep "${LOOP_DURATION}"
done
