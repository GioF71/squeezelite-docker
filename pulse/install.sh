#!/bin/sh

cp squeezelite-docker-pulse.service ~/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user enable squeezelite-docker-pulse --now
