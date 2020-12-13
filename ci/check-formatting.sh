#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash

black . --check --diff
