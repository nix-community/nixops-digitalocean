import sys
import subprocess

from distutils.core import setup, Command


setup(name='nixops-digitalocean',
      version='@version@',
      description='NixOS cloud deployment tool, but for digitalocean',
      url='https://github.com/NixOS/nixops-digitalocean',
      # TODO: add author
      author='',
      author_email='',
      packages=[ 'nixopsdigitalocean', 'nixopsdigitalocean.backends', 'nixopsdigitalocean.resources'],
      package_data={'nixopsdigitalocean': ['data/nixos-infect']},
      entry_points={'nixops': ['digitalocean = nixopsdigitalocean.plugin']},
      py_modules=['plugin']
)
