.PHONY: all lint help

all: lint

help:
	@echo "options:"
	@echo "  make lint  - Pull docker image for lint rtl code"

lint:
	@bash script/lint.sh
