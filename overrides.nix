{ pkgs }:

self: super: {
  nixops = super.nixops.overridePythonAttrs ({ nativeBuildInputs ? [ ], ... }: {
    format = "pyproject";
    nativeBuildInputs = nativeBuildInputs ++ [ self.poetry ];
  });
  sphinx = super.sphinx.overridePythonAttrs
    ({ propagatedBuildInputs ? [ ], ... }: {
      propagatedBuildInputs = propagatedBuildInputs ++ [ self.setuptools ];
    });
}
