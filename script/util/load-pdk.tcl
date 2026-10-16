# Função para carregar .env em Tcl puro
proc load_env_file { env_path } {
    if {[file exists $env_path]} {
        set fp [open $env_path r]
        set file_data [read $fp]
        close $fp

        foreach line [split $file_data "\n"] {
            set line [string trim $line]
            if {$line ne "" && ![string match "#*" $line]} {
                set kv [split $line "="]
                set key [string trim [lindex $kv 0]]
                set val [string trim [join [lrange $kv 1 end] "="]]
                if {![info exists ::env($key)]} {
                    set ::env($key) $val
                }
            }
        }
    }
}

load_env_file ".env"

set PDK_ROOT_SELECTED		  [info exists ::env(PDK_ROOT)]
set PDK_VERSION_SELECTED          [info exists ::env(PDK_V)]
set PDK_STANDARD_LIBRARY_SELECTED [info exists ::env(PDK_STD_LIB)]
set PDK_TYPICAL_LIBRARY_SELECTED  [info exists ::env(PDK_TT_LIB)]
set PDK_SLOW_LIBRARY_SELECTED     [info exists ::env(PDK_SS_LIB)]
set PDK_FAST_LIBRARY_SELECTED	  [info exists ::env(PDK_FF_LIB)]

if { $PDK_ROOT_SELECTED 
  && $PDK_VERSION_SELECTED 
  && $PDK_STANDARD_LIBRARY_SELECTED
  && $PDK_TYPICAL_LIBRARY_SELECTED 
  && $PDK_SLOW_LIBRARY_SELECTED 
  && $PDK_FAST_LIBRARY_SELECTED } {
	puts "PDK Root:             $::env(PDK_ROOT)"
	puts "PDK Version:          $::env(PDK_V)"
	puts "PDK Standard Library: $::env(PDK_STD_LIB)"
	puts "PDK Typical Library:  $::env(PDK_TT_LIB)"
	puts "PDK Slow Library:     $::env(PDK_SS_LIB)"
	puts "PDK Fast Library:     $::env(PDK_FF_LIB)"
} else {
	puts "Run: Make env PDK_ROOT=<PDK_ROOT> PDK_V=<PDK_V> PDK_STD_LIB=<PDK_STD_LIB> PDK_TT_LIB=<PDK_TT_LIB> PDK_SS_LIB=<PDK_SS_LIB> PDK_FF_LIB=<PDK_FF_LIB>"
	exit 1
}

set pdk         "$::env(PDK_V)"
set std_lib     "$::env(PDK_STD_LIB)"
set lib_path    "$::env(PDK_ROOT)/$pdk/libs.ref/$std_lib"
set lib_ff_path "$lib_path/lib/$::env(PDK_FF_LIB)"
set lib_ss_path "$lib_path/lib/$::env(PDK_SS_LIB)"
set lib_tt_path "$lib_path/lib/$::env(PDK_TT_LIB)"
