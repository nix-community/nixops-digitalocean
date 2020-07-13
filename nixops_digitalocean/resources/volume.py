# -*- coding: utf-8 -*-

# Automatic provisioning of DO volumes.


import os
import os.path

import nixops.resources
import nixops.util
import nixops.known_hosts

import digitalocean  # type: ignore


class DOVolumeDefinition(nixops.resources.ResourceDefinition):
    """Definition of a DO volume."""

    @classmethod
    def get_type(cls):
        return "do-volume"

    @classmethod
    def get_resource_type(cls):
        return "doVolumes"

    def show_type(self):
        return "{0}".format(self.get_type())

    def __init__(self, xml, config):
        nixops.resources.ResourceDefinition.__init__(self, xml, config)
        self.auth_token = config["authToken"]
        self.region = config["region"]
        self.size_gigabytes = config["sizeGigabytes"]
        self.volume_id = config["volumeId"]


class DOVolumeState(nixops.resources.ResourceState):
    """State of a DO volume."""

    state = nixops.util.attr_property(
        "state", nixops.resources.ResourceState.MISSING, int
    )
    auth_token = nixops.util.attr_property("authToken", None)
    region = nixops.util.attr_property("region", None)
    size_gigabytes = nixops.util.attr_property("sizeGigabytes", int)
    volume_id = nixops.util.attr_property("volumeId", None)

    @classmethod
    def get_type(cls):
        return "do-volume"

    def __init__(self, depl, name, id):
        nixops.resources.ResourceState.__init__(self, depl, name, id)

    def _exists(self):
        return self.state != self.MISSING

    def show_type(self):
        s = super(DOVolumeState, self).show_type()
        if self._exists():
            s = "{0} [{1}; {2} GiB]".format(s, self.region, self.size_gigabytes)
        return s

    @property
    def resource_id(self):
        return self.volume_id

    def create(self, defn, check, allow_reboot, allow_recreate):
        # self.authToken = defn.config["authToken"]

        if self.volume_id is not None:
            return

        self.manager = digitalocean.Manager(token=self.get_auth_token())
        volume = digitalocean.Volume(
            token=self.get_auth_token(),
            name=self.name,
            region=defn.region,
            size_gigabytes=defn.size_gigabytes,
            file_system_type="ext4",
        )
        self.log_start("creating volume ...")
        volume.create()
        volume.load()
        self.volume_id = volume.id
        self.log_end("{}".format(volume.id))

    def destroy(self, wipe=False):
        self.log("destroying volume {}".format(self.volume_id))
        try:
            volume = digitalocean.Volume(id=self.volume_id, token=self.get_auth_token())
            volume.destroy()
        except digitalocean.baseapi.NotFoundError:
            self.log("volume not found - assuming it's been destroyed already")
        self.volume_id = None

        return True

    def get_auth_token(self):
        return os.environ.get("DIGITAL_OCEAN_AUTH_TOKEN", self.auth_token)
