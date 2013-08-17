#!/bin/bash

# Terminate script on error
set -e

CONF_DIR=$(dirname $0)

echo "Setup bundle"
( cd $CONF_DIR && bundle install )

echo "Setup compass"
( cd $CONF_DIR && compass init --config config.rb )
