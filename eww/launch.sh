#!/bin/bash
 
if hash eww >/dev/null 2>&1; then
	pkill eww
    eww open -c ~/.config/eww/bar bar &
fi
