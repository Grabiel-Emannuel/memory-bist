#!/bin/bash

PDK_ROOT=$1;
PDK_VERSION=$2;
PDK_STANDARD_LIBRARY=$3;
PDK_TT_LIB=$4
PDK_SS_LIB=$5
PDK_FF_LIB=$6

if [ $# -ne 6 ]; 
	then echo "usage: bash load-env.sh PDK_ROOT PDK_VERSION PDK_STANDARD_LIBRARY PDK_TYPICAL_LIBRARY PDK_SLOW_LIBRARY PDK_FAST_LIBRARY"
	     echo "$#"
	     exit 1;
	fi;

export PDK_ROOT=$PDK_ROOT;
export PDK_V=$PDK_VERSION;
export PDK_STD_LIB=$PDK_STANDARD_LIBRARY;
export PDK_TT_LIB=$PDK_TT_LIB;
export PDK_SS_LIB=$PDK_SS_LIB;
export PDK_FF_LIB=$PDK_FF_LIB;

echo "PASS: Environment variables are set!"
