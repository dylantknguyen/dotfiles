#!/bin/zsh

if [[ "$1" =~ ^- && ! "$1" == "--" && -n $3 ]];
  then case $1 in
        -s | --screen )
            if [[ $2 == "inc" ]] ; then
                light -A $3
            elif [[ $2 == "dec" ]] ; then
                light -U $3
            elif [[ $2 == "set" ]] ; then
                light -S $3 
            elif [[ $2 == "get" ]] ; then
                light -G $3 
            else
              echo 'invalid command'
            fi
            ;;
        -k | --keyboard )
            if [[ $2 == "inc" ]] ; then
                light -s sysfs/leds/tpacpi::kbd_backlight -A $3
            elif [[ $2 == "dec" ]] ; then
                light -s sysfs/leds/tpacpi::kbd_backlight -U $3
            elif [[ $2 == "set" ]] ; then
                light -s sysfs/leds/tpacpi::kbd_backlight -S $3
            elif [[ $2 == "get" ]] ; then
                light -s sysfs/leds/tpacpi::kbd_backlight -G $3
            else
              echo 'invalid command'
            fi
            ;;
          *)
            echo 'invalid device'
            ;;
  esac; 
else
    if [[ -z $3 ]]; then
        echo 'no value given'
    else
        echo 'no params given'
    fi
fi
