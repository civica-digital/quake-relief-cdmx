.PHONY: dev ci bundle prepare test analyze deploy build push provide clean help

dev: docker-compose.override.yml bundle prepare ## Setup your Docker development environment
	@docker images --filter 'dangling=true' -q \
		| xargs docker rmi -f 2> /dev/null; true
	docker-compose up -d

ci: bundle prepare test analyze ## Run the CI strategy (prepare, test, analyze)

bundle: ## Rebuild the image and run the bundle lock
	docker-compose build web
	@docker-compose down 2> /dev/null; true
	docker-compose run --rm --no-deps web bundle lock

prepare: tmp log ## Prepare the test environment and run migrations
	docker-compose run --rm web rake db:create test:prepare db:migrate

test: ## Run the test suite
	docker-compose run --rm web rake spec

analyze: ## Run the static analysis suite
	docker-compose run --rm --no-deps web rubocop
	docker-compose run --rm --no-deps web rails_best_practices
	docker-compose run --rm --no-deps web reek
	docker-compose run --rm --no-deps web brakeman --no-progress -q -w3 -z
	docker-compose run --rm --no-deps -e HOME=/tmp web bundle-audit check --update --ignore CVE-2017-5029

deploy: build push provide ## Run the deploy strategy (build, push, provide)

IMAGE := $(REPOSITORY):$(TAG)
build: ## Build the staging/production Docker image
	docker build \
		--tag $(IMAGE) \
		--pull=true $(WORKSPACE) \
		--build-arg release_commit=$(shell git rev-parse HEAD)
ifeq ($(DEPLOY_ENV), "staging")
	# Persist the image layers to speed the CI builds with cache
	docker build --tag $(IMAGE) $(REPOSITORY):latest
endif

push: ## Push the Docker image to the registry
	@$(shell aws --profile docker ecr get-login --no-include-email)
	docker push $(IMAGE)

provide: ## Provide the HOST with the Docker image
	ssh -o StrictHostKeyChecking=no \
		$(HOST) bash -l -s < deploy/scripts/update-container.sh $(IMAGE)

clean: ## Remove dangling images
	@docker-compose down
	@docker rmi -f $(IMAGE); true
	@docker images --filter 'dangling=true' -q | xargs docker rmi -f; true

docker-compose.override.yml:
	@echo "version: '3'"      >> docker-compose.override.yml
	@echo "services:"         >> docker-compose.override.yml
	@echo "  db:"             >> docker-compose.override.yml
	@echo "    ports:"        >> docker-compose.override.yml
	@echo "      - 5432:5432" >> docker-compose.override.yml
	@echo "  web:"            >> docker-compose.override.yml
	@echo "    ports:"        >> docker-compose.override.yml
	@echo "      - 3000:3000" >> docker-compose.override.yml
ifeq ($(shell uname), Linux)
	@echo "    user: $(UID):$(GID)" >> docker-compose.override.yml
	@echo "  spring:"               >> docker-compose.override.yml
	@echo "    user: $(UID):$(GID)" >> docker-compose.override.yml
endif

tmp:
	mkdir -p tmp

log:
	mkdir -p log

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
