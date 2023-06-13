#!/bin/zsh

if [[ $(systemctl is-active bluetooth) != 'active' ]]; then
  [ "$UID" -eq 0 ] || exec sudo zsh "$0" "$@"

  systemctl start bluetooth

  sleep 0.5
fi

echo -e 'power on\nconnect\nquit' | bluetoothctl

echo "connected"
