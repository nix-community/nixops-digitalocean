#!/usr/bin/env bash

find . -name "*.nix" -exec nixfmt -c {} +
