{
  config_exporters = { optionalAttrs, ... }: [
    (config: { droplet = optionalAttrs (config.deployment.targetEnv == "droplet") config.deployment.droplet; })
  ];
  options = [
    ./droplet.nix
  ];
  resources = { evalResources, zipAttrs, resourcesByType, ... }: {
  };
}
