#!/bin/bash
WORK_DIR=$(pwd)

mkdir -p sim log

for tb_path in tb/*.sv; do
    
    FILE_NAME=$(basename "$tb_path" .sv)
    
    echo $FILE_NAME

    docker run --rm -v "$WORK_DIR:/work:z" verilator/verilator \
        --trace --binary -sv --Wall \
        -Mdir sim/obj_$FILE_NAME \
        "$tb_path" rtl/* 2>&1 | tee log/verilator_$FILE_NAME.log
        
    ./sim/obj_$FILE_NAME/V$FILE_NAME 2>&1 | tee log/V$FILE_NAME.log
done
