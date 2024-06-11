#!/bin/bash

# Default to color unless --no-color is specified
USE_COLOR=true

# Check for the '--no-color' flag
for arg in "$@"; do
    if [ "$arg" = "--no-color" ]; then
        USE_COLOR=false
        break
    fi
done

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Function to log messages with a timestamp
log() {
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") - $1"
}

# Function for debug messages
debug() {
    if [ "$USE_COLOR" = true ]; then
        log "DEBUG: $1"
    else
        log "DEBUG: $1"
    fi
}

# Function for info messages
info() {
    log "INFO: $1"
}

# Function for success messages
succ() {
    if [ "$USE_COLOR" = true ]; then
        log "${GREEN}SUCCESS: $1${NC}"
    else
        log "SUCCESS: $1"
    fi
}

# Function for warning messages
warn() {
    if [ "$USE_COLOR" = true ]; then
        log "${ORANGE}WARN: $1${NC}"
    else
        log "WARN: $1"
    fi
}

# Function for error messages
err() {
    if [ "$USE_COLOR" = true ]; then
        log "${RED}ERROR: $1${NC}"
    else
        log "ERROR: $1"
    fi
}

print_error_and_exit() {
    err "$1"
    exit 1
}
