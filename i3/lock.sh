#!/bin/bash

i3lock \
--insidever-color=1a1b26cc \
--ringver-color=7aa2f7ff \
\
--insidewrong-color=1a1b26cc \
--ringwrong-color=f7768eff \
\
--inside-color=11121dcc \
--ring-color=3b4261ff \
--line-color=00000000 \
--separator-color=00000000 \
\
--verif-color=c0caf5ff \
--wrong-color=f7768eff \
--time-color=c0caf5ff \
--date-color=9aa5ceff \
--layout-color=c0caf5ff \
--keyhl-color=7aa2f7ff \
--bshl-color=f7768eff \
\
--screen 1 \
--blur 7x5 \
--clock \
--indicator \
--time-str="%H:%M:%S" \
--date-str="%A, %d %B %Y" \
--keylayout 1 \
--radius 110 \
--ring-width 12 \
--verif-text="Verifying..." \
--wrong-text="Wrong Password" \
--noinput-text="" \
--lock-text="" \
--lockfailed-text="" \
--inside-color=00000088
