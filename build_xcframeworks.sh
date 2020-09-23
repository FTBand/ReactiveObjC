#!/bin/bash

# --------------------
# Delete old artifacts
# --------------------

# ReactiveObjC

rm -rf './artifacts/ReactiveObjC.xcframework'

# ----------------------------------
# Build Platform specific frameworks
# ----------------------------------

# iOS device

xcodebuild archive \
    -workspace 'ReactiveObjC.xcworkspace' \
    -scheme 'ReactiveObjC-iOS' \
    -configuration Release \
    -sdk iphoneos \
    -archivePath './artifacts/ReactiveObjC.framework-iphoneos.xcarchive' \
    SKIP_INSTALL=NO \
    | xcpretty

# iOS simulator

xcodebuild archive \
    -workspace 'ReactiveObjC.xcworkspace' \
    -scheme 'ReactiveObjC-iOS' \
    -configuration Release \
    -sdk iphonesimulator \
    -archivePath './artifacts/ReactiveObjC.framework-iphonesimulator.xcarchive' \
    SKIP_INSTALL=NO \
    | xcpretty

# -------------------
# Package xcframework
# -------------------

# ReactiveObjC

xcodebuild -create-xcframework \
    -framework './artifacts/ReactiveObjC.framework-iphoneos.xcarchive/Products/ReactiveObjC.framework' \
    -framework './artifacts/ReactiveObjC.framework-iphonesimulator.xcarchive/Products/ReactiveObjC.framework' \
    -output './artifacts/ReactiveObjC.xcframework'
