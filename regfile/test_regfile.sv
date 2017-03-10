`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:19:01 04/07/2015
// Design Name:   regfile
// Module Name:   /home/alex/verilog/core1/test_regfile.v
// Project Name:  core1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regfile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

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
		read_addr_a <= 7;
		read_addr_b <= 3;
		// Add stimulus here
	end
	always begin
		#10	clk <= ~clk;
        
		// Add stimulus here

	end
      
endmodule

