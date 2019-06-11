install:
	poetry install

build:
	poetry build

package: build

publish:
	poetry publish -r internal

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
