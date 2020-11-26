#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash
set -eux

git ls-files | xargs codespell -L keypair,iam,hda
sphinx-build -M clean doc/ doc/_build
sphinx-build -n doc/ doc/_build
