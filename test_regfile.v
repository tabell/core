`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:59:39 04/07/2015
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
	reg [4:0] read_addr;
	reg [4:0] write_addr;
	reg write_enable;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.read_data(read_data), 
		.write_data(write_data), 
		.read_addr(read_addr), 
		.write_addr(write_addr), 
		.write_enable(write_enable), 
		.clk(clk),
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		write_data = 0;
		read_addr = 0;
		write_addr = 0;
		write_enable = 0;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        rst <= 0;
		// Add stimulus here
	end
	always begin
		#10	clk <= ~clk;
	end
      
endmodule

