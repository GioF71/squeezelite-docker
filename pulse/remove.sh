#!/bin/sh

systemctl --user stop squeezelite-docker-pulse
systemctl --user disable squeezelite-docker-pulse
rm ~/.config/systemd/user/squeezelite-docker-pulse.service
systemctl --user daemon-reload


