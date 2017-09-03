#!/bin/bash

### KILL ADB server
lsof -i tcp:5037 | grep adb | grep "localhost:5037 " |  awk -F ' ' '{print $2}' | xargs kill -9  > /dev/null 2>&1
adb devices > /dev/null 2>&1
## BUILD HARNESS module check if emulator is ART or DVM 
rt=`echo "ls /system/lib/libdvm.so 2>/dev/null | wc -l" | xargs adb shell | tr -d '[:space:]'`
if [ $rt -eq 0 ]; then
    # ART 
    cd harness_art
    make && make install
else
    # DVM
    cd harness
    make && make install
fi
### FORWARDING ABD
adb forward tcp:5001 tcp:5001
### RUNNING SERVER
adb shell /data/local/tmp/harness /data/local/tmp/libstr-crypt.so
