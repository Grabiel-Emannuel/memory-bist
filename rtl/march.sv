module march #(
	parameter integer AWIDTH=5,
	parameter integer DWIDTH=8	
) (
	input 	     		  clk, rst_n, en,
	output logic 	          write, read, fault,
	output logic [AWIDTH-1:0] addrress,
	inout  wire  [DWIDTH-1:0] data
);

	timeunit      1ns;
	timeprecision 1ps;

	typedef enum logic [1:0] {
		WRITE,
		READ,
		ADDRESS,
		END_OF
	} instruction_t;

	typedef enum logic {
		ZERO,
		ONE	
	} argument_t;

	typedef struct packed {
		instruction_t instruction;
		argument_t    argument;
	} line_t;

	typedef struct packed {
		logic  [4:0]  program_counter, last_address, last_line;
		line_t [31:0] code;
	} march_program_t;

	typedef struct packed {
		logic [AWIDTH-1:0] address;
		logic 		   write, read, fault, value, asc_addr;
	} state_t;

endmodule
