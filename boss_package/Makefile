.PHONY: install build package publish show config version shell check lock add-repository creds-repository prepare deploy wheelhouse

install:
	poetry install

build:
	poetry build

package: build

publish:
	poetry publish -vvv -r internal -u jarvis -p password --build

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

creds-repository:
	poetry config http-basic.internal jarvis password

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

global-install:
	pip3 install tox twine auditwheel pex mkdocs pre-commit pyscaffold pyroma flit hatch

wheelhouse:
	bash travis/build-wheels-stretch-slim-docker.sh
	ls wheelhouse

add-vulture:
	echo " [run] Find dead Python code"
	poetry add vulture

add-eradicate:
	echo " [run] Find dead Python code"
	poetry add eradicate
