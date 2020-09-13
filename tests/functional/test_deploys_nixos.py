from nose import tools

from tests.functional import single_droplet_test


class TestDeploysNixos(single_droplet_test.SingleDropletTest):
    def run_check(self):
        self.depl.deploy()
        self.check_command("test -f /etc/NIXOS")
