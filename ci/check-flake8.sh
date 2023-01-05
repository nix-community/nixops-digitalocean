#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash

exec flake8 nixops_digitalocean tests/unit
