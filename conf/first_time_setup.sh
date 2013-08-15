#!/bin/bash

# Terminate script on error
set -e

echo "Setup compass"
( cd conf && compass init --config config.rb )

echo "Setup bundle"
( cd conf && bundle install )
