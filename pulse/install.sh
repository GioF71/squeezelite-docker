#!/bin/sh

cp squeezelite-pulse.service ~/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user enable squeezelite-pulse
