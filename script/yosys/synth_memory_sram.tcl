source "script/util/load-pdk.tcl"
source "script/yosys/helper.tcl"

set file_name "rtl/memory_sram.sv"
set attributes [dict create \
	AWIDTH 4	
]
set top_module "memory_sram"
set netlist_prefix "netlist/memory_sram"
set netlist_tt_path "${netlist_prefix}_tt.v"
set netlist_ss_path "${netlist_prefix}_ss.v"
set netlist_ff_path "${netlist_prefix}_ff.v"
set timing 20000

read_file  $file_name $attributes
synthetize $file_name $attributes $top_module $lib_tt_path $netlist_tt_path $timing
reset_design

read_file  $file_name $attributes
synthetize $file_name $attributes $top_module $lib_ss_path $netlist_ss_path $timing
reset_design

read_file  $file_name $attributes
synthetize $file_name $attributes $top_module $lib_ff_path $netlist_ff_path $timing
reset_design
