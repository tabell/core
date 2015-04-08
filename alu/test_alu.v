`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:45 04/07/2015
// Design Name:   alu
// Module Name:   /home/alex/verilog/core1/alu/test_alu.v
// Project Name:  core1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define func_add 0'b100000
`define func_addu 0'b100001
`define func_addi 0'b001000
`define func_addiu 0'b001001
`define func_and 0'b100100
`define func_andi 0'b001100
`define func_div 0'b011010
`define func_divu 0'b011011
`define func_mult 0'b011000
`define func_multu 0'b011001
`define func_nor 0'b100111
`define func_or 0'b100101
`define func_ori 0'b001101
`define func_sll 0'b000000
`define func_sllv 0'b000100
`define func_sra 0'b000011
`define func_srav 0'b000111
`define func_srl 0'b000010
`define func_srlv 0'b000110
`define func_sub 0'b100010
`define func_subu 0'b100011
`define func_xor 0'b100110
`define func_xori 0'b001110

module test_alu;

	// Inputs
	reg [31:0] operand_a;
	reg [31:0] operand_b;
	reg [5:0] func;

	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.operand_a(operand_a),
		.operand_b(operand_b),
		.result(result),
		.func(func)
	);

	initial begin
		// Initialize Inputs
		operand_a = 0;
		operand_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
		operand_a <= 100;
		operand_b <= 75;
		func <= `func_add;
		#20;
		operand_a <= 7;
		operand_b <= 7;
		func <= `func_sub;
		#20;
		operand_a <= 999;
		operand_b <= 1;
		#20;
		operand_a <= 9999;
		operand_b <= 9999;
		#20;
		operand_a <= 99999;
		operand_b <= -999;
        
		// Add stimulus here

	end
      
endmodule

