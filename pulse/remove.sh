#!/bin/sh

systemctl --user stop squeezelite-pulse
systemctl --user disable squeezelite-pulse
rm ~/.config/systemd/user/squeezelite-pulse.service
systemctl --user daemon-reload


