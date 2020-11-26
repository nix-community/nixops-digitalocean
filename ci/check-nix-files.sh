#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash

find . -name "*.nix" -exec nix-instantiate --parse --quiet {} >/dev/null +
