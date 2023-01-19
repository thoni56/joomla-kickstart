USER = thoni56
UBUNTU = jammy
PHP = 8.0

all:
	UBUNTU=$(UBUNTU) PHP=$(PHP) envsubst '$$UBUNTU $$PHP $$USER' < Dockerfile.template > Dockerfile
	docker build -t $(USER)/joomla-kickstart:$(UBUNTU)-$(PHP) .
	@echo "Build done."
	@echo "Copy your kickstart backup file(s) to the 'restore' directory"
	@echo "and 'make run', then navigate to localhost:8080 to start"
	@echo "the restoration process."

NAME = `ls restore/site*.jpa | awk -F\- '{ printf "%s-%s",$$2,$$3 }'`

run:
	docker run -v $(PWD)/restore:/restore -p 80:80 -p 443:443 --name $(NAME) $(USER)/joomla-kickstart:$(UBUNTU)-$(PHP)
