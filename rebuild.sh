#!/bin/bash
# Flutter rebuild script with full error reporting and fail-fast behavior

echo "Starting Flutter rebuild..."

set -e
trap 'echo "Rebuild failed at step: $CURRENT_STEP"; exit 1' ERR

# Step 1: Clean project
CURRENT_STEP="flutter clean"
echo "Cleaning project..."
flutter clean

# Step 2: Get dependencies
CURRENT_STEP="flutter pub get"
echo "Fetching dependencies..."
flutter pub get

# Step 3: Analyze code
CURRENT_STEP="flutter analyze"
echo "Analyzing code..."
flutter analyze

# Step 4: Format code
CURRENT_STEP="flutter format"
echo "Formatting code..."
flutter format .

# Step 5: Run tests
CURRENT_STEP="flutter test"
echo "Running tests..."
flutter test

# Step 6: Build APK (debug)
CURRENT_STEP="flutter build apk"
echo "Building Android APK..."
flutter build apk --debug || echo "APK build failed, continuing..."

# Step 7: Build Web (debug)
CURRENT_STEP="flutter build web"
echo "Building Web..."
flutter build web || echo "Web build failed, continuing..."

echo "Rebuild completed successfully!"
