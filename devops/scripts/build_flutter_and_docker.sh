#!/bin/bash

# Source the utility script wiht optional passed argument of --no-color (used for logging)
source ./devops/scripts/utils.sh "$@"

# Define the file where the version is stored
VERSION_FILE="version.txt"

# Check if the version file exists
if [ ! -f "$VERSION_FILE" ]; then
    echo "0.0.1" >"$VERSION_FILE"
fi

# Read the current version
VERSION=$(cat "$VERSION_FILE")

# Increment the version (simple PATCH increment)
IFS='.' read -ra ADDR <<<"$VERSION"
if [ ${#ADDR[@]} -eq 3 ]; then
    PATCH=${ADDR[2]}
    MINOR=${ADDR[1]}
    MAJOR=${ADDR[0]}
    PATCH=$((PATCH + 1))
    VERSION="$MAJOR.$MINOR.$PATCH"
else
    print_error_and_exit "Version format error."
    exit 1
fi

# Save the new version back to the file
echo "$VERSION" >"$VERSION_FILE"

info "Building Flutter Web App..."
flutter build web

info "Building Docker Image..."
docker build -t vocabmate:$VERSION .

info "Build and tag complete. Image version: $VERSION"
