from os import path

from nose import tools
from nose.plugins.attrib import attr

from tests.functional import generic_deployment_test

parent_dir = path.dirname(__file__)

test_spec = "{0}/single_droplet_base.nix".format(parent_dir)


class SingleDropletTest(generic_deployment_test.GenericDeploymentTest):
    _multiprocess_can_split_ = True

    def setup(self):
        super(SingleDropletTest, self).setup()
        self.depl.nix_exprs = [test_spec]

    def test_do_droplet(self):
        self.run_check()

    def check_command(self, command):
        self.depl.evaluate()
        machine = next(iter(self.depl.machines.values()))
        return machine.run_command(command)
