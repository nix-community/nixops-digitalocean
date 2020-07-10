import os.path
import nixops.plugins


class NixopsDigitalOceanPlugin(nixops.plugins.Plugin):

    @staticmethod
    def nixexprs():
        return [os.path.dirname(os.path.abspath(__file__)) + "/nix"]

    @staticmethod
    def load():
        return [
            "nixops_digitalocean.resources",
            "nixops_digitalocean.backends.droplet",
        ]


@nixops.plugins.hookimpl
def plugin():
    return NixopsDigitalOceanPlugin()
