#!/usr/bin/env bash
source .env

AAX_DIR=/downloads

for aax in $(find "${AAX_DIR}" -type f -name "*.aax")
do
	dest="$(dirname "${aax}")/$(basename "${aax}" .aax).m4b"
	if [[ -f "${dest}" ]]; then
		echo "File exists, not overwriting: ${dest}"
	else
		ffmpeg -loglevel repeat+warning -activation_bytes "${ACTIVATION_BYTES}" -i "${aax}" -vn -c:a copy -disposition:v:1 attached_pic "${dest}"
	fi
done
