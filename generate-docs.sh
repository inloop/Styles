#!/bin/bash
jazzy --readme ./README.md --no-objc --podspec ./Styles.podspec -c --output ./docs/swift
jazzy --readme ./README.md --objc --output ./docs/objc -c
