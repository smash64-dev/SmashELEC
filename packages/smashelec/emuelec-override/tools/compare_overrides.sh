#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

is_text() {
	file -i "$1" | cut -d':' -f2 | grep -q 'text'
}

BASE_DIR="$(dirname $(dirname $(readlink -f $0)))"
CONFIG_DIR="${BASE_DIR}/config"
SX05RE_DIR="$(echo "$BASE_DIR" | sed 's|smashelec.*|sx05re|g')"

OLD_IFS="$IFS"
IFS=$'\n'

OVERRIDES="$(find "$BASE_DIR" -type f ! -path '*package.mk')"
for override in $OVERRIDES; do
	file_name="$(echo "$override" | sed "s|${BASE_DIR}/||g")"
	originals="$(find "$SX05RE_DIR" -type f -name "$(basename "$override")" ! -path '*emulationstation-addon*')"

	if [[ -n "$originals" ]]; then
		echo -e "\n\n=== $file_name ==="

		for original in $originals; do
			if is_text "$override" && is_text "$original"; then
				diff "$original" "$override"
			else
				md5sum "$override"
				md5sum "$original"
			fi
		done
	fi
done

IFS="$OLD_IFS"
