`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    alu 
// Project Name:   llama
// Target Devices: Xilinx Spartan 6 - LX9
// Tool versions:  Xilinx ISE 14.7 (64 bit) Linux
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module alu(
	input [31:0] operand_a,
	input [31:0] operand_b,
	input [5:0] func,
	output [31:0] result,
	output [3:0] flags, // neg, zer, ovflw, equal ?
	input clk,
	input clk_en
	);

	reg [31:0] result;

	wire [31:0] operand_a;
	wire [31:0] operand_b;
	wire [5:0] func;

	always @(posedge clk) begin
		case (func)
			32 : result <= operand_a + operand_b; // add
			8 : result <= operand_a + operand_b; // addi
			36 : result <= operand_a & operand_b; // and
			37 : result <= operand_a | operand_b; // or
			43 : result <= operand_a | ~operand_b; // nor
			34 : result <= operand_a - operand_b; // sub
			// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			0 : result <= operand_b << operand_a; // sll 000000
			4 : result <= operand_b << operand_a; // sllv 000100
			// 2 : result <= operand_a + operand_b; // srl 000010
			// 3 : result <= operand_a + operand_b; // sra 000011
			// 6 : result <= operand_a + operand_b; // srlv 000110
			// 7 : result <= operand_a + operand_b; // srav 000111
			// 9 : result <= operand_a + operand_b; // addiu 001001
			// 12 : result <= operand_a + operand_b; // andi 001100
			// 13 : result <= operand_a + operand_b; // ori 001101
			// 14 : result <= operand_a + operand_b; // xori 001110
			// 24 : result <= operand_a + operand_b; // mult 011000
			// 25 : result <= operand_a + operand_b; // multu 011001
			// 26 : result <= operand_a + operand_b; // div 011010
			// 27 : result <= operand_a + operand_b; // divu 011011
			// 33 : result <= operand_a + operand_b; // addu 100001
			// 35 : result <= operand_a + operand_b; // subu 100011
			// 38 : result <= operand_a + operand_b; // xor 100110
			default : result <= 32'hZ;
		endcase
	end
endmodule