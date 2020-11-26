#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash
set -eu

scratch=$1
sub=$2

exec mypy \
    --any-exprs-report "$scratch/$sub" \
    --linecount-report "$scratch/$sub" \
    --lineprecision-report "$scratch/$sub" \
    --txt-report "$scratch/$sub" \
    nixops_digitalocean
