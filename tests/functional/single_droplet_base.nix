{
  network.description = "NixOps DigitalOcean Test";
  resources.sshKeyPairs.ssh-key = { };

  machine = {
    deployment.targetEnv = "droplet";
    deployment.droplet = {
      region = "nyc3";
      size = "s-1vcpu-1gb";
    };
  };
}
