auth:
	mkdir auth

packages:
	mkdir packages

.PHONY: up
up: auth packages
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: docker-enter
enter:
	docker-enter

.PHONY: stop-bash
stop-bash:
	docker-compose down bash

.PHONY: up-bash
up-bash:
	docker-compose up -d bash

.PHONY: project
project:
	poetry new boss_package

.PHONY: logs
logs:
	docker-compose logs -f
