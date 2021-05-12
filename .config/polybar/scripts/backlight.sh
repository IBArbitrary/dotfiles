#!/bin/bash

xbacklight -getf | cut -d. -f1 | awk '{printf "%3d", $1}'
