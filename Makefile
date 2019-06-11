.PHONY: up
up:
	docker-compose up -d

.PHONY: docker-enter
enter:
	docker-enter

.PHONY: stop-bash
stop-bash:
	docker-compose down bash

.PHONY: up-bash
up-bash:
	docker-compose up -d bash

project:
	poetry new boss_package
