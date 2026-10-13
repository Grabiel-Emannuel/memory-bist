#!/bin/bash
docker run --rm -v $(pwd):/work:z verilator/verilator --lint-only -sv -Wall rtl/* tb/*
