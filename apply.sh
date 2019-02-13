#!/bin/bash

apply() {
	[ ! -n "$ANDROID_BUILD_TOP" ] && echo "Please specify ANDROID_BUILD_TOP before running this script" && return
	source $ANDROID_BUILD_TOP/android_local_manifests_i9300/common.sh

	while read line; do
		proj=$(echo $line | cut -d " " -f1)
		echo -e $CL_BLU"Applying patches to $proj"$CL_RST
		echo
		git -C $ANDROID_BUILD_TOP/$(echo $line)
		echo ""; echo "";
	done < $ANDROID_BUILD_TOP/android_local_manifests_i9300/patches.txt
}

apply
