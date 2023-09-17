#!/usr/bin/env bash

check_required_command() {
    # Check if the required command(s)
    for cmd in "$@"; do
        if ! command -v "${cmd}" >/dev/null 2>&1; then
            echo "Error: ${cmd} is not installed or not in PATH."
            exit 1
        fi
    done
}
