#!/bin/bash -x

function my_beep {
   beep -f 600 -r 2 -d 30
}

for((;;))
do
  sleep 1200
  my_beep
  zenity --forms --text="Pomodoro calls to rest"
  if [ $? -ne 0 ]; then break; fi
  sleep 240
  my_beep
  zenity --forms --text="Pomodoro calls to work"
  if [ $? -ne 0 ]; then break; fi
done
