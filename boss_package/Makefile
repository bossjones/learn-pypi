.PHONY: install build package publish show config version shell check lock add-repository creds-repository prepare deploy wheelhouse

# add-repository creds-repository
bootstrap: poetry-activate
	bash travis/bootstrap.sh

setup: add-repository creds-repository

install:
	poetry install

build:
	poetry build

package: build

publish:
	poetry publish -vvv -r internal -u jarvis -p password --build || true
	poetry publish -vvv -r pypiserver-default -u jarvis -p password --build || true

show:
	poetry show

config:
	poetry config --list

version:
	poetry run python -V

shell:
	poetry shell

check:
	poetry check

lock:
	poetry lock

add-repository:
	poetry config repositories.internal http://pypi/simple/
	poetry config repositories.pypiserver-default http://pypiserver-default:8080/simple/

creds-repository:
	poetry config http-basic.internal jarvis password
	poetry config http-basic.pypiserver-default jarvis password

prepare: show build

deploy: prepare publish

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

clean: clean-build clean-pyc ## clean build artifacts and python file artifacts

cli:
	pickley install tox twine auditwheel pex mkdocs pre-commit pyscaffold pyroma flit hatch

global-install: bootstrap
	pip3 install tox twine auditwheel pex mkdocs pre-commit pyscaffold pyroma flit hatch

wheelhouse:
	bash travis/build-wheels-test.sh

add-vulture:
	echo " [run] Find dead Python code"
	poetry add vulture

add-eradicate:
	echo " [run] Find dead Python code"
	poetry add eradicate

logs:
	( cd ..; docker-compose logs -f )

stop-manylinux:
	( cd ..; docker-compose stop manylinux )

up-manylinux:
	( cd ..; docker-compose up -d manylinux )

restart-manylinux: stop-manylinux up-manylinux

twine-package:
	python setup.py sdist bdist_wheel

twine-upload:
	# twine upload --repository-url http://pypi/legacy/ dist/*
	twine auto-upload pyproject.toml

keyring:
	keyring set http://pypi/legacy/ jarvis
	keyring set http://pypi/legacy/ jarvis

poetry-activate:
	echo " [run] 'source $$HOME/.poetry/env'"

dephell:
	pip install dephell[full]
	pip install dephell-discover
	dephell autocomplete || true

dephell-convert:
# dephell deps convert --from=pyproject.toml --to=setup.py
	dephell deps convert

register:
	python setup.py sdist register -r internal upload -r internal
