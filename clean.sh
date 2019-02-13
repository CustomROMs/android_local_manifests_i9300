#!/bin/bash

clean() {
	[ ! -n "$ANDROID_BUILD_TOP" ] && echo "Please specify ANDROID_BUILD_TOP before running this script" && return
	source $ANDROID_BUILD_TOP/android_local_manifests_i9300/common.sh

	projects=""
	while read line; do
		proj=$(echo $line | cut -d " " -f1)
		echo -e $CL_BLU"Cleaning up $proj"$CL_RST
		echo
		git -C $ANDROID_BUILD_TOP/$proj clean -fd
		projects="$projects $ANDROID_BUILD_TOP/$proj"
		echo ""; echo "";
	done < $ANDROID_BUILD_TOP/android_local_manifests_i9300/patches.txt
	repo sync -fl $projects
}

clean
