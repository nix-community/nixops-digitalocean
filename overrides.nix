{ pkgs }:

self: super: {
  nixops = super.nixops.overridePythonAttrs ({ nativeBuildInputs ? [ ], ... }: {
    format = "pyproject";
    nativeBuildInputs = nativeBuildInputs ++ [
      self.pluggy
      self.poetry
      self.prettytable
      self.typeguard
      self.typing-extensions
    ];
  });
}
