#!/usr/bin/env python3
import os
#xbacklight -getf | cut -d. -f1 | awk '{printf "sike %3s", $1}'
cmd = "xbacklight -getf | cut -d. -f1"
#brightness = os.system(cmd)
os.system("echo a {}".format(os.system(cmd)))
