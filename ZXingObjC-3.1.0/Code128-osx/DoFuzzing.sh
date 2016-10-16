#!/bin/bash

BASE_DIR=$(dirname $0)

FUZZER=./afl-fuzz
TEST_CASES=$BASE_DIR/Input
RESULT_DIR=$BASE_DIR/Result
TARGET_APP=$BASE_DIR/ZXingDecoder

# Clear
rm -rf $RESULT_DIR/*

# Disable Crash Reporter
launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist 
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

# export AFL_NO_FORKSRV=1
# Do Fuzzing
$FUZZER -i $TEST_CASES -o $RESULT_DIR -t 30000 $TARGET_APP @@
