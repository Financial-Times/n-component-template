node_modules/@financial-times/n-gage/index.mk:
	npm install --no-save @financial-times/n-gage
	touch $@

-include node_modules/@financial-times/n-gage/index.mk

build: $(shell find src -type f)
	@echo 'Building…'
	@rm -rf dist
	@babel src -d dist --ignore '**/__tests__/*.js'

test: verify lint unit-test

test-cover: verify lint unit-test-cover

unit-test:
	@echo 'Unit Testing…'
	@jest

unit-test-watch:
	@jest --watch

unit-test-cover:
	@jest --coverage

lint:
	@echo 'linting…'
	@eslint src

lint-fix:
	@eslint src --fix

lint-watch:
	@nodemon --watch src -q --exec 'make lint-fix'

bootstrap:
	@./scripts/bootstrap.sh

