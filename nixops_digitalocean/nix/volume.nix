{ config, lib, uuid, name, ... }:

with lib;

{
  imports = [
    # TODO <-- refactor out in-common options
  ];
  options = {
    region = mkOption {
      default = "";
      example = "nyc3";
      type = types.str;
      description = ''
        The region. See https://status.digitalocean.com/ for a list
        of regions.
      '';
    };

    authToken = mkOption {
      default = "";
      example =
        "8b2f4e96af3997853bfd4cd8998958eab871d9614e35d63fab45a5ddf981c4da";
      type = types.str;
      description = ''
        The API auth token. We're checking the environment for
        <envar>DIGITAL_OCEAN_AUTH_TOKEN</envar> first and if that is
        not set we try this auth token.
      '';
    };

    sizeGigabytes = mkOption {
      default = "";
      example = "100";
      type = types.int;
      description = ''
        The size of the volume in gigabytes.
      '';
    };

    volumeId = mkOption {
      default = "";
      example = "vol-abc123";
      type = types.str;
      description = ''
        The volume id to be imported into the NixOps do-volume resource.
      '';
    };
    # self.id = None
    # self.name = None
    # self.droplet_ids = []
    # self.region = None
    # self.description = None
    # self.created_at = None
    # self.snapshot_id = None
    # self.filesystem_type = None
    # self.filesystem_label = None
    # self.tags = None
  };
  config = { _type = "do-volume"; };
}
