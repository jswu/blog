#!/bin/bash

# Bail on errors
set -e

function clean_up() {
  set +e
  kill 0
  exit
}

# Kill all child processes on script abort
trap clean_up SIGTERM SIGINT ERR

echo "Starting compass watch"
compass watch conf &

echo "Starting Jekyll server"
jekyll --server --auto

# Only exit on terminate or interrupt signal
while true; do
  sleep 1
done
