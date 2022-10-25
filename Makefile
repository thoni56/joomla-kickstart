all:
	docker build -t thoni56/joomla-kickstart:focal-7.4 .

run:
	docker run -v $(PWD)/restore:/restore -p 8080:80 thoni56/joomla-kickstart:focal-7.4
