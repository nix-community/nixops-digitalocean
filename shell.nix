{ pkgs ? import <nixpkgs> {} }:
let
  overrides = import ./overrides.nix { inherit pkgs; };
in pkgs.mkShell {
  buildInputs = [
    (pkgs.poetry2nix.mkPoetryEnv {
      projectDir = ./.;
      python = pkgs.python37;
      overrides = pkgs.poetry2nix.overrides.withDefaults overrides;
    })
    pkgs.poetry
  ];
}
