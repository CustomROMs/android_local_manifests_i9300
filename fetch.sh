#!/bin/bash

path2name()
{
	echo android_"$1" | sed "s,/,_,g"
}

fetch() {
	[ ! -n "$ANDROID_BUILD_TOP" ] && echo "Please specify ANDROID_BUILD_TOP before running this script" && return
	source $ANDROID_BUILD_TOP/android_local_manifests_i9300/common.sh

	while read line; do
		proj=$(echo $line | cut -d " " -f1)
		echo -e $CL_BLU"Fetching patches for $proj"$CL_RST
		echo
		echo "git -C $ANDROID_BUILD_TOP/$proj fetch https://github.com/CustomROMS/$(path2name $proj) lineage-16.0"
		git -C $ANDROID_BUILD_TOP/$proj fetch https://github.com/CustomROMS/$(path2name $proj) lineage-16.0
		echo ""; echo "";
	done < $ANDROID_BUILD_TOP/android_local_manifests_i9300/patches.txt
}

fetch
