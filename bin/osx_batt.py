#!/usr/bin/env python
# coding=UTF-8
# script by Steve Losh:
# http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/#my-right-prompt-battery-capacity

import math, subprocess

p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0]

o_max = [l for l in output.splitlines() if 'MaxCapacity' in l][0]
o_cur = [l for l in output.splitlines() if 'CurrentCapacity' in l][0]

b_max = float(o_max.rpartition('=')[-1].strip())
b_cur = float(o_cur.rpartition('=')[-1].strip())

charge = b_cur / b_max
charge_threshold = int(math.ceil(10 * charge))

# Output

total_slots, slots = 10, []
filled = int(math.ceil(charge_threshold * (total_slots / 10.0))) * u'▸'
empty = (total_slots - len(filled)) * u'▹'

out = (filled + empty).encode('utf-8')
import sys

color_green = '%{$fg[green]%}'
color_yellow = '%{$fg[yellow]%}'
color_red = '%{$fg[red]%}'
color_reset = '%{$reset_color%}'
color_out = (
    color_green if len(filled) > 6
    else color_yellow if len(filled) > 4
    else color_red
)

out = color_out + out + color_reset
sys.stdout.write(out)
