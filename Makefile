TIMESTAMP := $(shell date +'%Y-%m%-d_%H-%M-%S')

all: help

help:
	@echo "options:"
	@echo "  make env       - Load environments with:"
	@echo "                 -   PDK_ROOT"
	@echo "                 -   PDK_VERSION"
	@echo "                 -   PDK_STD_LIB"
	@echo "                 -   PDK_TT_LIB"
	@echo "                 -   PDK_SS_LIB"
	@echo "                 -   PDK_FF_LIB"
	@echo "  make lint      - Lint rtl & tb code"
	@echo "  make log-check - Check log simulations"
	@echo "  make pull      - Pull verilator image"
	@echo "  make test      - Run testbench simulations"
	@echo "  make synth     - Run a Yosys Synth script. Use SCRIPT=<script file_name>"

env:
	@echo "PDK_ROOT=$(PDK_ROOT)"       >  .env
	@echo "PDK_V=$(PDK_VERSION)"       >> .env
	@echo "PDK_STD_LIB=$(PDK_STD_LIB)" >> .env
	@echo "PDK_TT_LIB=$(PDK_TT_LIB)"   >> .env
	@echo "PDK_SS_LIB=$(PDK_SS_LIB)"   >> .env
	@echo "PDK_FF_LIB=$(PDK_FF_LIB)"   >> .env

lint:
	@bash script/make/lint.sh

log-check:
	@bash script/make/log-check.sh

pull:
	@bash script/make/pull.sh

test:
	@bash script/make/test.sh

synth:
	yosys -c script/yosys/$(SCRIPT) 2>&1 | tee log/$(basename ${SCRIPT})_$(TIMESTAMP).log
