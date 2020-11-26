{ pkgs }:

self: super: {
  nixops = super.nixops.overridePythonAttrs ({ nativeBuildInputs ? [ ], ... }: {
    format = "pyproject";
    nativeBuildInputs = nativeBuildInputs ++ [
      self.poetry
      self.prettytable
      self.typeguard
      self.typing-extensions
      self.pluggy
      self.prettytable
    ];
    propagatedBuildInputs = [ self.setuptools ];
  });
  sphinx = super.sphinx.overridePythonAttrs
    ({ propagatedBuildInputs ? [ ], ... }: {
      propagatedBuildInputs = propagatedBuildInputs ++ [ self.setuptools self.wheel self.pip ];
    });
}
