{ pkgs }:

self: super: {
  nixops = super.nixops.overridePythonAttrs ({ nativeBuildInputs ? [ ], ... }: {
    format = "pyproject";
    nativeBuildInputs = nativeBuildInputs ++ [
      self.pluggy
      self.poetry
      self.prettytable
      self.prettytable
      self.typeguard
      self.typing-extensions
    ];
    propagatedBuildInputs = [ self.setuptools ];
  });
  sphinx = super.sphinx.overridePythonAttrs
    ({ propagatedBuildInputs ? [ ], ... }: {
      propagatedBuildInputs = propagatedBuildInputs
        ++ [ self.setuptools self.wheel self.pip ];
    });
  typeguard = super.typeguard.overridePythonAttrs
    ({ nativeBuildInputs ? [ ], ... }: {
      format = "pyproject";
      nativeBuildInputs = nativeBuildInputs ++ [ self.poetry ];
      propagatedBuildInputs = [ self.setuptools ];
    });
  mypy = super.mypy.overridePythonAttrs (old: {
    propagatedBuildInputs = old.propagatedBuildInputs
      ++ [ self.lxml self.pip self.setuptools ];
  });
}
