USER = thoni56
UBUNTU = jammy
PHP = 8.0

all:
	UBUNTU=$(1) PHP=$(2) envsubst '$$UBUNTU $$PHP' < Dockerfile.template > Dockerfile
	docker build -t $USER/joomla-kickstart:$UBUNTU-$PHP .
	@echo "Build done."
	@echo "Copy your kickstart backup file(s) to the restore directory"
	@echo "and 'make run', then navigate to localhost:8080 to start"
	@echo "the restoration process."


run:
	docker run -v $(PWD)/restore:/restore -p 8080:80 thoni56/joomla-kickstart:focal-7.4
