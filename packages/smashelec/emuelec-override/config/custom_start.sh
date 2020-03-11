#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

# Place any scripts you need to run at boot on this file
# This may start too late for some of the things you want to do

# base directory for smashelec scripts
SE_DIR="/storage/.config/smashelec/scripts"

. "$SE_DIR/hotplug_detection.sh"
