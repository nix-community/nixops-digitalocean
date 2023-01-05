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
  zipp = super.zipp.overridePythonAttrs (old: {
    propagatedBuildInputs = old.propagatedBuildInputs ++ [ self.toml ];
  });
  mypy = super.mypy.overridePythonAttrs (old: {
    propagatedBuildInputs = old.propagatedBuildInputs
      ++ [ self.lxml self.pip self.setuptools ];
  });
}
