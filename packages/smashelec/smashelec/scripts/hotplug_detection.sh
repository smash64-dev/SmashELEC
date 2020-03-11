#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present CEnnis91 (https://github.com/cennis91)

. /etc/profile


hdmi_plugged() {
	HDMI_DIR="/sys/class/amhdmitx/amhdmitx0"

	if [[ "$(cat "${HDMI_DIR}/hpd_state")" == "1" ]]; then
		return 0
	else
		return 1
	fi
}

set_ra_setting() {
	local key="$1"
	local value="$2"

	local ra_config="/storage/.config/retroarch/retroarch.cfg"

	sed -i "/$key[ ]\+=/d" "$ra_config"
	echo "${key} = \"${value}\"" >> "$ra_config"
}

set_audio_device() {
	local audio_device="$1"
	set_se_setting "ee_audio_device" "$audio_device"
	sed -i "s|pcm \"hw:.*|pcm \"hw:${audio_device}\"|" /storage/.config/asound.conf
	set_audio "alsa"

	set_ra_setting "audio_device" "hw:${audio_device}"
}

set_resolution() {
	local resolution="$1"
	local setres

	setres="$(which setres.sh)"
	if [[ -z "$setres" ]]; then
		setres="/storage/.config/emuelec/scripts/setres.sh"
	fi

	echo "$resolution" > /sys/class/display/mode
	set_se_setting "ee_videomode" "$resolution"
	"$setres"
}


CUR_RES="$(cat /sys/class/display/mode)"
EE_RES="$(get_se_setting ee_videomode)"

CVBS_RES="$(get_se_setting se_auto_cvbs)"
CVBS_RES="${CVBS_RES:-$CUR_RES}"
HDMI_RES="$(get_se_setting se_auto_hdmi)"
HDMI_RES="${HDMI_RES:-$CUR_RES}"

if hdmi_plugged; then
	if [[ "$CUR_RES" != "$HDMI_RES" ]]; then
		se_logger "HDMI detected, changing to $HDMI_RES"
		set_se_setting "se_videomode_last" "$CUR_RES"
		set_resolution "$HDMI_RES"
	fi

	# always set the audio device
	set_audio_device "0,0"

	# 22 = Core Provided
	set_ra_setting "aspect_ratio_index" "22"
else
	if [[ "$CUR_RES" != "$CVBS_RES" ]]; then
		se_logger "CVBS detected, changing to $CVBS_RES"
		set_se_setting "se_videomode_last" "$CUR_RES"
		set_resolution "$CVBS_RES"
	fi

	# always set the audio device
	set_audio_device "0,1"

	# 1 = 16:9
	set_ra_setting "aspect_ratio_index" "1"
fi
