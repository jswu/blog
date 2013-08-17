SHELL=/bin/bash

.PHONY: default local setup-first-time clean

default: local

# Hmm having everything in conf/ creates confusion, revert to before
local:
	./conf/start_server.sh

setup-first-time:
	./conf/first_time_setup.sh

build:
	./build_html.sh

clean:
	find . -name '*.pyc' -delete
	rm -rf static/css
