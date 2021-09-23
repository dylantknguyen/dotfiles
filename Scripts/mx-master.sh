#!/bin/zsh

if [[ $(systemctl is-active bluetooth) != 'active' ]]; then
  [ "$UID" -eq 0 ] || exec sudo zsh "$0" "$@"

  systemctl start bluetooth

  sleep 0.5

  echo -e 'power on\nconnect \t \nquit' | bluetoothctl

  sleep 0.5

  systemctl start logid

  echo "connected"
else
  [ "$UID" -eq 0 ] || exec sudo zsh "$0" "$@"

  systemctl stop bluetooth
  systemctl stop logid
  echo "stopped"
fi
