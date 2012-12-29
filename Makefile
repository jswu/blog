SHELL=/bin/bash

.PHONY: local setup clean

# Hmm having everything in conf/ creates confusion, revert to before
local:
	./conf/local_server.sh

setup:
	./conf/setup.sh

clean:
	find . -name '*.pyc' -delete
	rm -rf static/css
