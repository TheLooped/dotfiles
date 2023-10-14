#!/usr/bin/env bash

killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
 polybar logo &
 polybar tags &
 polybar window &
 polybar layout &
 polybar date &
 polybar battery &

    2>&1 | tee -a /tmp/polybar1.log & disown

