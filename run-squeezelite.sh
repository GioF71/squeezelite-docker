#!/bin/sh

sed -i 's/MPD_AUDIO_DEVICE/'"$MPD_AUDIO_DEVICE"'/g' /etc/mpd.conf
sed -i 's/ALSA_DEVICE_NAME/'"$ALSA_DEVICE_NAME"'/g' /etc/mpd.conf
sed -i 's/MIXER_TYPE/'"$MIXER_TYPE"'/g' /etc/mpd.conf
sed -i 's/MIXER_DEVICE/'"$MIXER_DEVICE"'/g' /etc/mpd.conf
sed -i 's/MIXER_CONTROL/'"$MIXER_CONTROL"'/g' /etc/mpd.conf
sed -i 's/MIXER_INDEX/'"$MIXER_INDEX"'/g' /etc/mpd.conf
sed -i 's/DOP/'"$DOP"'/g' /etc/mpd.conf

sed -i 's/QOBUZ_PLUGIN_ENABLED/'"$QOBUZ_PLUGIN_ENABLED"'/g' /etc/mpd.conf
sed -i 's/QOBUZ_APP_ID/'"$QOBUZ_APP_ID"'/g' /etc/mpd.conf
sed -i 's/QOBUZ_APP_SECRET/'"$QOBUZ_APP_SECRET"'/g' /etc/mpd.conf
sed -i 's/QOBUZ_USERNAME/'"$QOBUZ_USERNAME"'/g' /etc/mpd.conf
sed -i 's/QOBUZ_PASSWORD/'"$QOBUZ_PASSWORD"'/g' /etc/mpd.conf
sed -i 's/QOBUZ_FORMAT_ID/'"$QOBUZ_FORMAT_ID"'/g' /etc/mpd.conf

sed -i 's/TIDAL_PLUGIN_ENABLED/'"$TIDAL_PLUGIN_ENABLED"'/g' /etc/mpd.conf
sed -i 's/TIDAL_APP_TOKEN/'"$TIDAL_APP_TOKEN"'/g' /etc/mpd.conf
sed -i 's/TIDAL_USERNAME/'"$TIDAL_USERNAME"'/g' /etc/mpd.conf
sed -i 's/TIDAL_PASSWORD/'"$TIDAL_PASSWORD"'/g' /etc/mpd.conf
sed -i 's/TIDAL_AUDIOQUALITY/'"$TIDAL_AUDIOQUALITY"'/g' /etc/mpd.conf

sed -i 's/REPLAYGAIN_MODE/'"$REPLAYGAIN_MODE"'/g' /etc/mpd.conf
sed -i 's/REPLAYGAIN_PREAMP/'"$REPLAYGAIN_PREAMP"'/g' /etc/mpd.conf
sed -i 's/REPLAYGAIN_MISSING_PREAMP/'"$REPLAYGAIN_MISSING_PREAMP"'/g' /etc/mpd.conf
sed -i 's/REPLAYGAIN_LIMIT/'"$REPLAYGAIN_LIMIT"'/g' /etc/mpd.conf
sed -i 's/VOLUME_NORMALIZATION/'"$VOLUME_NORMALIZATION"'/g' /etc/mpd.conf

cat /etc/mpd.conf

/usr/bin/mpd --no-daemon /etc/mpd.conf
