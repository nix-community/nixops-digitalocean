from os import path
from nose import tools

from tests.functional import single_droplet_test

parent_dir = path.dirname(__file__)

ipv6_spec = "%s/single_droplet_ipv6.nix" % (parent_dir)

class TestIpv6(single_droplet_test.SingleDropletTest):
    _multiprocess_can_split_ = True

    def setup(self):
        super(TestIpv6, self).setup()
        self.depl.nix_exprs = self.depl.nix_exprs + [ipv6_spec]

    def run_check(self):
        self.depl.deploy()
        m = list(self.depl.active.values())[0]
        tools.assert_not_equals(m.public_ipv6["address"], None)
