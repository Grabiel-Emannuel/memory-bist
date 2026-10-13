module tb_memory_sram;

	timeunit      1ns;
	timeprecision 1ps;

	localparam integer AWIDTH=5,
			   DWIDTH=8,
			   PERIOD=20;

	logic 		   clk, write, read;
	logic [AWIDTH-1:0] address;
	logic [DWIDTH-1:0] data_in;
	wire  [DWIDTH-1:0] data, impendant;

	integer		   error_count;

	assign data 	 = write ? data_in : 'z;
	assign impendant = 'z;

	memory_sram #(.AWIDTH, .DWIDTH) DUT (.*);

	initial begin 
		$monitor("[t=%0.1f ns] write=%b read=%b address=%0h | data=%0h",
			  $realtime, write, read, address, data);
	end

	initial begin 
		clk = 1'b0;
	end

	always begin 
		#(PERIOD / 2) clk = ~clk;	
	end

	task check;
		input logic 	         write_v, read_v;
		input logic [AWIDTH-1:0] address_v;
		input logic [DWIDTH-1:0] data_write, data_expected;
		input integer		 wait_time;
		begin 
			write=write_v; read=read_v; address=address_v;
			data_in=data_write;
			/* verilator lint_off ZERODLY */
			#wait_time;
			/* verilator lint_on ZERODLY */
			if (read_v && (data_expected !== data)) begin 
				$display("ERROR: write=%b read=%b address=%0h | data_expected=%0h got=%0h",
					  write, read, address, data_expected, data);
				error_count++;
			end
		end
	endtask

	initial begin 
		error_count = 0;

		for (int ad = 0; ad < (2**AWIDTH)-1; ad++) begin 
			for (int dt = 0; dt < (2**DWIDTH)-1; dt++) begin 
				//    write read  address         data write      data expected  wait time
				check(1'b1, 1'b0, ad[AWIDTH-1:0], dt[DWIDTH-1:0], impendant,     PERIOD);
				check(1'b0, 1'b1, ad[AWIDTH-1:0], impendant, 	  dt[DWIDTH-1:0],PERIOD);
				check(1'b0, 1'b1, ad[AWIDTH-1:0], impendant, 	  dt[DWIDTH-1:0],PERIOD);
			end
		end

		if (error_count == 0) begin 
			$display("\n*** PASS: Memory SRAM is a success! ***");
		end

		else begin 
			$display("\n*** FAIL: %0d errors from memory SRAM! ***",
				 error_count);
		end

		$finish;
	end

endmodule
