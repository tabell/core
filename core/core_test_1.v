`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:45:06 04/13/2015
// Design Name:   core
// Module Name:   /home/alex/verilog/core1/core_test_1.v
// Project Name:  core1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module core_test_1;

	// Inputs
	reg clk;
	reg rst;
	reg clk_en;

	// Instantiate the Unit Under Test (UUT)
	core uut (
		.clk(clk), 
		.rst(rst), 
		.clk_en(clk_en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		clk_en = 0;

		// Wait 100 ns for global reset to finish
		#100 rst <= 0;

		#50 clk_en <= 1;
        
		// Add stimulus here

	end

	always begin
		#10 clk <= ~clk;
	end
      
endmodule

