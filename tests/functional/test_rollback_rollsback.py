from os import path
from nose import tools

from tests.functional import single_droplet_test

from nixops.ssh_util import SSHCommandFailed

parent_dir = path.dirname(__file__)

has_hello_spec = "%s/single_droplet_has_hello.nix" % (parent_dir)

rollback_spec = "%s/single_droplet_rollback.nix" % (parent_dir)


class TestRollbackRollsback(single_droplet_test.SingleDropletTest):
    _multiprocess_can_split_ = True

    def setup(self):
        super(TestRollbackRollsback, self).setup()
        self.depl.nix_exprs = self.depl.nix_exprs + [rollback_spec]

    def run_check(self):
        self.depl.deploy()
        with tools.assert_raises(SSHCommandFailed):
            self.check_command("hello")
        self.depl.nix_exprs = self.depl.nix_exprs + [has_hello_spec]
        self.depl.deploy()
        self.check_command("hello")
        self.depl.rollback(generation=1)
        with tools.assert_raises(SSHCommandFailed):
            self.check_command("hello")
