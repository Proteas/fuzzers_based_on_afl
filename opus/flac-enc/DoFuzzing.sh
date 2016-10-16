#!/bin/bash
set -e

pushd `dirname $0` > /dev/null
BASE_DIR=`pwd`
popd > /dev/null
# ================================================================ #

FUZZER=./afl-fuzz
TEST_CASES=${BASE_DIR}/Input
RESULT_DIR=${BASE_DIR}/Result
TARGET_APP=${BASE_DIR}/opusenc
# ================================================================ #

# Clear
rm -rf ${TEST_CASES}/.DS_Store
rm -rf ${RESULT_DIR}/*
# ================================================================ #

# Disable Crash Reporter
# launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist
# ================================================================ #

# export AFL_NO_FORKSRV=1
# export AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
# ================================================================ #

# Do Fuzzing
${FUZZER} -i ${TEST_CASES} -o ${RESULT_DIR} -t 20000 ${TARGET_APP} - /dev/null
# ================================================================ #
