.PHONY: all lint help

all: help

help:
	@echo "options:"
	@echo "  make env       - Load environments with:"
	@echo "                 -   PDK_ROOT"
	@echo "                 -   PDK_VERSION"
	@echo "                 -   PDK_STANDARD_LIBRARY"
	@echo "                 -   PDK_TT_LIB"
	@echo "                 -   PDK_SS_LIB"
	@echo "                 -   PDK_FF_LIB"
	@echo "  make lint      - Lint rtl & tb code"
	@echo "  make log-check - Check log simulations"
	@echo "  make pull      - Pull verilator image"
	@echo "  make test      - Run testbench simulations"

env:
	@bash script/load-env.sh $(PDK_ROOT) $(PDK_VERSION) $(PDK_STD_LIB) $(PDK_TT_LIB) $(PDK_SS_LIB) $(PDK_FF_LIB) 

lint:
	@bash script/lint.sh

log-check:
	@bash script/log-check.sh

pull:
	@bash script/pull.sh

test:
	@bash script/test.sh
