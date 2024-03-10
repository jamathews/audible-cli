#!/usr/bin/env bash

cd /audible-cli
pip install .
audible download --all --aaxc
