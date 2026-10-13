.PHONY: all lint help

all: help lint log-check pull test

help:
	@echo "options:"
	@echo "  make lint 	 - Lint rtl & tb code"
	@echo "  make log-check - Check log simulations"
	@echo "  make pull      - Pull verilator image"
	@echo "  make test 	 - Run testbench simulations"

lint:
	@bash script/lint.sh

log-check:
	@bash script/log-check.sh

pull:
	@bash script/pull.sh

test:
	@bash script/test.sh
