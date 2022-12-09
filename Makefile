default:
	docker-compose exec php /bin/sh

install: prepare_files start composer_install
restart: stop start
restart_with_rebuild: stop start_with_rebuild

prepare_files:
	cp .env .env.local

start:
	docker-compose up -d

start_with_rebuild:
	docker-compose build php
	docker-compose up -d

stop:
	docker-compose stop

composer_install:
	docker-compose exec php composer install

composer_update:
	docker-compose exec php composer update
