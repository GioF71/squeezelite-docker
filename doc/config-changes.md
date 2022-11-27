# Notable changes to the configuration

A few environment variables have been deprecated, see the following table.

## Deprecated variables

Deprecated Variable|Deprecated Since|Comment
:---|:---|:---
SQUEEZELITE_SPECIFY_SERVER|2021-11-23|This variable is not required anymore: just set the `SQUEEZELITE_SERVER_PORT` variable
SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE|2022-01-24|Variable name too long, replaced with SQUEEZELITE_BUFFER_SIZE

For the new variables introduced over time, see the following table.

## New variables

New Variable|Availability Date|Comment
:---|:---|:---
AUDIO_GID|2022-11-27|Support for user mode for alsa output
SQUEEZELITE_LOG_CATEGORY_*|2022-10-07|Support for logging levels
SQUEEZELITE_MODE|2022-09-15|Introduced support for PulseAudio
PUID|2022-09-15|User id for PulseAudio Mode
PGID|2022-09-15|Group id for PulseAudio Mode
SQUEEZELITE_VISUALIZER|2022-06-09|Add support for visualizer (-v).
SQUEEZELITE_EXCLUDE_CODECS|2022-02-14|Added support for configuration option
SQUEEZELITE_RATES|2021-11-23|Added support for configuration option
SQUEEZELITE_UPSAMPLING|2021-11-23|Added support for configuration option
PRESET|2022-01-19|New feature
SQUEEZELITE_PARAMS|2022-01-19|Added support for configuration option
SQUEEZELITE_CODECS|2022-01-19|Added support for configuration option
SQUEEZELITE_PRIORITY|2022-01-19|Added support for configuration option
SQUEEZELITE_MIXER_DEVICE|2022-01-21|Added support for configuration option
SQUEEZELITE_MAC_ADDRESS|2022-01-21|Added support for configuration option
SQUEEZELITE_MODEL_NAME|2022-01-21|Added support for configuration option
SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE|2022-01-21|Added support for configuration option
SQUEEZELITE_BUFFER_SIZE|2022-01-24|Previous variable was too long.
SQUEEZELITE_VOLUME_CONTROL|2022-02-23|Added support for configuration option
SQUEEZELITE_UNMUTE|2022-02-23|Added support for configuration option
SQUEEZELITE_LINEAR_VOLUME|2022-02-23|Added support for configuration option
