#!/bin/bash

### KILL ADB server
lsof -i tcp:5037 | grep adb | grep "localhost:5037 " |  awk -F ' ' '{print $2}' | xargs kill -9
adb devices
