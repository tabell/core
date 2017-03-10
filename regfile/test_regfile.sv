`timescale 1ns / 1ps

module test_regfile;

	// Inputs
	reg [31:0] write_data;
	reg [4:0] read_addr_a;
	reg [4:0] read_addr_b;
	reg [4:0] write_addr;
	reg write_enable;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] read_data_a;
	wire [31:0] read_data_b;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.read_data_a(read_data_a), 
		.read_data_b(read_data_b), 
		.write_data(write_data), 
		.read_addr_a(read_addr_a), 
		.read_addr_b(read_addr_b), 
		.write_addr(write_addr), 
		.write_enable(write_enable), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		$monitor("t=%g a[%d] = %d, b[%d] = %d",
			$time, read_addr_a, read_data_a, read_addr_b, read_data_b);
		// Initialize Inputs
		write_data = 0;
		read_addr_a = 0;
		read_addr_b = 0;
		write_addr = 0;
		write_enable = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
        rst <= 1;
		#200;
        rst <= 0;
		#20 
		write_addr <= 7;
        write_data <= 327;
        write_enable <= 1;
        #20; 
		write_addr <= 3;
        write_data <= 36827;
        #20;
        write_enable <= 0;
        #20;
		#20 read_addr_a <= 7;
		#20 read_addr_b <= 3;
		// Add stimulus here
		$finish;
	end
	always begin
		#10	clk <= ~clk;
	end
      
endmodule

