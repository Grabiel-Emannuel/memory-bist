docker pull verilator/verilator

docker run --rm -v $(pwd):/work:z verilator --lint-only -sv -Wall rtl/*
