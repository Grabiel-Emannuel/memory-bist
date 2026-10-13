#!/bin/bash
WORK_DIR=$(pwd)

for log_path in log/Vtb_*.log; do

	[ -e "$log_path" ] || continue

	FILE_NAME=$(basename "$log_path" .log)

	if grep -qE "FAIL|ERROR" "$log_path"; then
        	echo "ERROR: $FILE_NAME. Fix and test again."
        	exit 1
    	fi

	if  grep -q "PASS" "$log_path"; then
        	echo "PASS: $FILE_NAME pass all tests!"
    	fi

done

for tb_path in tb/*.sv; do
	
	[ -e "$tb_path" ] || continue
	
	FILE_NAME=$(basename "$tb_path" .sv)

	if [ -f "log/V$FILE_NAME.log" ]; then
  		echo "PASS: $FILE_NAME have a testbench executed and passed all tests!"
	else
    		echo "FAIL: $FILE_NAME doesn't have a testbench executed."
		exit 1
	fi
done

for rtl_path in rtl/*.sv; do
	
	[ -e "$rtl_path" ] || continue
	
	FILE_NAME=$(basename "$rtl_path" .sv)

	if [ -f "tb/tb_$FILE_NAME.sv" ]; then 
		echo "PASS: $FILE_NAME have a testbench and passed all tests!"
	else 
		echo "FAIL: $FILE_NAME doesn't have a testbench. Create and runt it."
		exit 1
	fi

done
