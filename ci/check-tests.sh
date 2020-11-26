#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell ../shell.nix -i bash

./coverage-tests.py -a '!libvirtd,!gce,!ec2,!azure,!test_do_droplet' -v
