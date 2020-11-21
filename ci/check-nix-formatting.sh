#!/usr/bin/env nix-shell
#!nix-shell ../shell.nix -i bash

find . -name "*.nix" -exec nixpkgs-fmt --check {} +
