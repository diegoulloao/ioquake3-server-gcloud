#!/bin/sh

# Prepare script
# file in charge of fetch all quake3 missing dependencies

# exit on error
set -e

declare -r pak0="https://github.com/nrempel/q3-server/raw/master/baseq3/pak0.pk3"
declare -r pak="https://github.com/diegoulloao/ioquake3-mac-install/raw/master/dependencies/baseq3/pak@.pk3"

echo "\nChecking for Quake3 dependencies ..."

# if packages were fetched
FETCHED_PACKAGES=0

# fetch pak0.pk3
if [ ! -f lib/baseq3/pak0.pk3 ]; then
	echo "\n\033[0;37mMissing pak0.pk3\033[0m"
	echo "Downloading pak0.pk3 ..."

  curl -L $pak0 > lib/baseq3/pak0.pk3
  FETCHED_PACKAGES=1
fi

# packages counter
COUNT=1

# fetch pak[1-8].pk3
while [ $COUNT -lt 9 ]; do
  if [ ! -f lib/baseq3/pak$COUNT.pk3 ]; then
    echo "\n\033[0;37mMissing pak$COUNT.pk3\033[0m"
    echo "Downloading pak$COUNT.pk3 ...\n"

    curl -L ${pak/@/$COUNT} > lib/baseq3/pak$COUNT.pk3

    if [ $FETCHED_PACKAGES == 0 ]; then
      FETCHED_PACKAGES=1
    fi
  fi

	let COUNT+=1
done

# user feedback messages
if [ $FETCHED_PACKAGES == 1 ]; then
  echo "\n\033[0;32m-> pk3 files downloaded.\033[0m"
else
  echo "\n\033[0;32m-> pk3 files up to date ✓\033[0m"
fi

echo "\033[0;32m-> all dependencies are satisfied ✓\033[0m"
