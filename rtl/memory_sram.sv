module memory_sram #(
	parameter integer AWIDTH=5,
	parameter integer DWIDTH=8
) (
	input  logic 	          clk, write, read,
	input  logic [AWIDTH-1:0] address,
	inout  wire  [DWIDTH-1:0] data
);

	timeunit      1ns;
	timeprecision 1ps;

	logic [DWIDTH-1:0] array [(2**AWIDTH)-1:0];
	logic [DWIDTH-1:0] delivery;

	assign data = (read && (~write)) ? delivery : 'z;

	always_ff @(posedge clk) begin 
		if (write && (~read)) begin 
			array[address] <= data;
		end
		else if (read && (~write)) begin 
			delivery <= array[address];
		end
	end	

endmodule
