proc read_file { file_name attributes } {
	set cmd_flags [list]
	dict for {key value} $attributes {
		lappend cmd_flags "-G" "${key}=${value}"
	}
	lappend cmd_flags $file_name
	yosys read_slang {*}$cmd_flags
}

proc synthetize { file_name attributes top_module library netlist_path } {
	yosys hierarchy -top $top_module

	yosys proc 
	yosys fsm 
	yosys opt 
	yosys memory 
	yosys opt 
	yosys techmap 
	yosys opt
	
	yosys dfflibmap -liberty $library
	yosys abc       -liberty $library
	yosys clean
	
	yosys stat      -liberty $library

	yosys write_verilog      $netlist_path
}

proc reset_design {} {
	yosys design -reset
}
