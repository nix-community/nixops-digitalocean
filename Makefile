##
# NixopsDigitalOcean
#
# @file
# @version 0.1


.PHONY: fast-test good-test impure-test all-test format amend push


fast-ci-test: nix-shell
	./ci/check-flake8.sh
	./ci/check-nix-formatting.sh
	./ci/check-mypy.sh
	./ci/check-nix-files.sh
	./ci/check-formatting.sh
	./ci/check-tests.sh
	./ci/lint-docs.sh

functional-droplet-tests: nix-shell
	./coverage-tests.py

code-format:
	find . -name "*.nix" -exec nixfmt {} +
	black . --check

impure-test: nix-shell
	./ci/check-poetry.sh
	./lint-docs.sh
	./ci/mypy-ratchet.sh

nix-shell:
	nix-shell --run true

update-lock: #TODO

# end
