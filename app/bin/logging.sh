#!/bin/bash

set -ex

function add_log_categories() {
    if [ -n "${SQUEEZELITE_LOG_CATEGORY_ALL}" ]; then
        CMD_LINE="$CMD_LINE -d all=${SQUEEZELITE_LOG_CATEGORY_ALL}"
    fi

    if [ -n "${SQUEEZELITE_LOG_CATEGORY_SLIMPROTO}" ]; then
        CMD_LINE="$CMD_LINE -d slimproto=${SQUEEZELITE_LOG_CATEGORY_SLIMPROTO}"
    fi

    if [ -n "${SQUEEZELITE_LOG_CATEGORY_STREAM}" ]; then
        CMD_LINE="$CMD_LINE -d stream=${SQUEEZELITE_LOG_CATEGORY_STREAM}"
    fi

    if [ -n "${SQUEEZELITE_LOG_CATEGORY_DECODE}" ]; then
        CMD_LINE="$CMD_LINE -d decode=${SQUEEZELITE_LOG_CATEGORY_DECODE}"
    fi

    if [ -n "${SQUEEZELITE_LOG_CATEGORY_OUTPUT}" ]; then
        CMD_LINE="$CMD_LINE -d output=${SQUEEZELITE_LOG_CATEGORY_OUTPUT}"
    fi

    if [ -n "${SQUEEZELITE_LOG_CATEGORY_IR}" ]; then
        CMD_LINE="$CMD_LINE -d ir=${SQUEEZELITE_LOG_CATEGORY_IR}"
    fi
}