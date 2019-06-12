.PHONY: install build package publish show config version shell check lock add-repository creds-repository prepare deploy wheelhouse

PACKAGE_NAME := boss_package


.PHONY: help
help: ## ** Show this help message
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# add-repository creds-repository
bootstrap: poetry-activate global-install ## bootstrap all required deps
	bash travis/bootstrap.sh

setup: add-repository creds-repository  ## poetry: setup repository and creds

install: ## poetry: install
	poetry install

build: ## poetry: build
	poetry build

package: build ## poetry: build

publish: ## poetry: publish
	poetry publish -vvv -r internal -u jarvis -p password --build || true
	poetry publish -vvv -r pypiserver-default -u jarvis -p password --build || true

show: ## poetry show command
	poetry show

config: ## poetry: config list
	poetry config --list

version: ## poetry: run python --version
	poetry run python -V

shell: ## poetry: get shell
	poetry shell

check: ## poetry :check command
	poetry check

lock: ## poetry: create lock file
	poetry lock

add-repository: ## poetry: add internal pypi servers
	poetry config repositories.internal http://pypi/simple/
	poetry config repositories.pypiserver-default http://pypiserver-default:8080/simple/

creds-repository: ## poetry: configure internal pypi servers
	poetry config http-basic.internal jarvis password
	poetry config http-basic.pypiserver-default jarvis password

prepare: clean show build ## poetry: prepare package for pypi

deploy: clean prepare publish ## poetry: publish to pypi

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

clean: clean-build clean-pyc ## clean build artifacts and python file artifacts

cli: ## pickley install global python deps, not working due to execp error
	pickley install tox twine auditwheel pex mkdocs pre-commit pyscaffold pyroma flit hatch

global-install: # install python packages that should be global for dev env
	pip3 install tox twine auditwheel pex mkdocs pre-commit pyscaffold pyroma flit hatch pipenv

wheelhouse: ## generate wheelhouse
	bash travis/build-wheels-test.sh

add-vulture: ## poetry add vulture package to deps
	echo " [run] Find dead Python code"
	poetry add vulture

add-eradicate: ## poetry add eradicate package to deps
	echo " [run] Find dead Python code"
	poetry add eradicate

logs:
	( cd ..; docker-compose logs -f )

stop-manylinux:
	( cd ..; docker-compose stop manylinux )

up-manylinux:
	( cd ..; docker-compose up -d manylinux )

restart-manylinux: stop-manylinux up-manylinux

twine-package: ## package python module for source dist
	python setup.py sdist bdist_wheel

twine-upload: ## upload to local pypi
# twine upload --repository-url http://pypi/legacy/ dist/*
# twine auto-upload pyproject.toml
	twine upload --repository-url=http://pypi -u jarvis -p password dist/*

keyring: ## keyring set username to local pypi
	keyring set http://pypi/legacy/ jarvis
	keyring set http://pypi/legacy/ jarvis

poetry-activate: ## source $$HOME/.poetry/env
	echo " [run] 'source $$HOME/.poetry/env'"

dephell: ## Install dephell. Manage packages: convert between formats, lock, install, resolve, isolate, test, build graph, show outdated, audit. Manage venvs, build package, bump version
	pip install dephell[full]
	pip install dephell-discover
	dephell autocomplete || true

dephell-convert: ## convert from pyproject.toml to setup.py
# dephell deps convert --from=pyproject.toml --to=setup.py
	dephell deps convert

create-dist: clean ## create source distribution, this is what will be uploaded to pypi
	python setup.py sdist bdist_wheel

twine-register:  ## register package w/ local pypi
	twine register --repository-url=http://pypi -u jarvis -p password $(PACKAGE_NAME)

install-from-pypi: ## upload to local pypi server
	pip install --extra-index-url=http://pypi/simple/ --trusted-host pypi $(PACKAGE_NAME)
