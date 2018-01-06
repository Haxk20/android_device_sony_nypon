LOCAL_PATH=../../../..

CURRENT_DIR=$PWD

KERNEL_PATCH="kernel/codina/chrono"

if [ "$PATCHES" == "" ] ; then
	PATCHES="\
	art \
	bionic \
	build/make \
	build/soong \
	frameworks/av \
	frameworks/base \
	frameworks/opt/telephony \
	frameworks/native \
	bootable/recovery \
	external/minijail \
	external/boringssl \
	external/selinux
	hardware/libhardware \
	hardware/interfaces \
	system/core \
	system/extras \
	system/keymaster \
	system/media \
	system/netd \
	system/vold \
	system/security \
	system/sepolicy \
	vendor/lineage"
fi

export CL_RED="\033[31m"
export CL_GRN="\033[32m"
export CL_YLW="\033[33m"
export CL_BLU="\033[34m"
export CL_MAG="\033[35m"
export CL_CYN="\033[36m"
export CL_RST="\033[0m"

pre_clean() {
    tmp=$PWD
    cd $1

    git reset --hard > /dev/null 2>&1
    git clean -fd > /dev/null 2>&1
    git am  --abort > /dev/null 2>&1

    cd $tmp

    out=$( repo sync -fl $1 )
}

commit_quiet()
{
  git commit -am "$1" 1>.tmp 2>&1;
  if cat .tmp | grep -i "nothing" >/dev/null ; then
      echo -e $CL_RED"patch $1 is already applied, removing this patch"$CL_RST
      rm $1
  fi

  rm .tmp
}

apply() {
    out=$( patch -p1 -i $1 )
    fail=$( echo $out | grep -ic "FAILED" )
    ign=$( echo $out | grep -ic "ignore" )

    if [ "$fail" == "0" ]  ; then
         commit_quiet "$1"
         if [ "$ign" != "0" ]  ; then
             echo -e $CL_YLW"some hunks of patch $1 has been ignored"$CL_RST
             #echo -e $CL_RED$out$CL_RST | tr '.' '\n'
         fi
    else 
         echo -e $CL_RED"patch $1 applies with errors -> reject"$CL_RST
	 git reset --hard > /dev/null 2>&1

         #echo -e $CL_RED$l$CL_RST | tr '.' '\n'
    fi;
    for i in $(find . -name "*.rej" -o -name "*.orig"); do rm $i; done
}

apply_all() {
    tmp=$PWD
    cd $1

    echo -e $CL_BLU"Applying patches to $1"$CL_RST ; echo "" ; echo "" ;

    for i in $( ls *.patch )
    do
        echo "applying "$i
        if [ "$1" != "$KERNEL_PATCH" ] ; then
            apply $i
        else
            git am $i
        fi
        echo ""
    done
 
    cd $tmp
}

# pre clean 

echo -e $CL_GRN"get rid of any uncommitted or unstaged changes"$CL_RST

patches=$PWD
cd $LOCAL_PATH

for i in $PATCHES
do
	if [ -n "$(echo $i | grep '#')" ] ; then
		continue
	fi

	pre_clean $i
done


if [ "$1" != "clean" ]; then

	cd $patches

	# copy patches
	cp -r * $LOCAL_PATH 
	cd $LOCAL_PATH

	# now apply it 

	for i in  $PATCHES
	do
		if [ -n "$(echo $i | grep '#')" ] ; then
			continue
		fi

		if test -f RESET; then
			/bin/bash RESET
		fi

		apply_all $i
	done
fi

cd $CURRENT_DIR

export PATCHES=""
