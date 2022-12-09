default:
	docker-compose exec app /bin/sh

install: prepare_files start composer_install migrate
restart: stop start
restart_with_rebuild: stop start_with_rebuild
restart_with_override: stop_with_override start_with_override

prepare_files:
	cp .env .env.local

start:
	docker-compose up -d

start_with_rebuild:
	docker-compose build app
	docker-compose up -d

start_with_override:
	docker-compose -f docker-compose.yaml -f docker-compose.override.yaml up -d

stop_with_override:
	docker-compose -f docker-compose.yaml -f docker-compose.override.yaml stop

stop:
	docker-compose stop

composer_install:
	docker-compose exec app composer install

composer_update:
	docker-compose exec app composer update
