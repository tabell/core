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

	always @(operand_a or operand_b or func) begin
		case (func)
			32 : result <= operand_a + operand_b; // add
			36 : result <= operand_a & operand_b; // and
			37 : result <= operand_a | operand_b; // or
			43 : result <= operand_a | ~operand_b; // nor
			34 : result <= operand_a - operand_b; // sub
			// -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			// 5'b100001 : result <= operand_a + operand_b; // addu (this is unimplimented)
			// 5'b001000 : result <= operand_a + operand_b; // addi (this is unimplimented)
			// 5'b001001 : result <= operand_a + operand_b; // addiu (this is unimplimented)
			// 5'b001100 : result <= operand_a + operand_b; // andi (this is unimplimented)
			// 5'b011010 : result <= operand_a + operand_b; // div (this is unimplimented)
			// 5'b011011 : result <= operand_a + operand_b; // divu (this is unimplimented)
			// 5'b011000 : result <= operand_a + operand_b; // mult (this is unimplimented)
			// 5'b011001 : result <= operand_a + operand_b; // multu (this is unimplimented)
			// 5'b001101 : result <= operand_a + operand_b; // ori (this is unimplimented)
			// 5'b000000 : result <= operand_a + operand_b; // sll (this is unimplimented)
			// 5'b000100 : result <= operand_a + operand_b; // sllv (this is unimplimented)
			// 5'b000011 : result <= operand_a + operand_b; // sra (this is unimplimented)
			// 5'b000111 : result <= operand_a + operand_b; // srav (this is unimplimented)
			// 5'b000010 : result <= operand_a + operand_b; // srl (this is unimplimented)
			// 5'b000110 : result <= operand_a + operand_b; // srlv (this is unimplimented)
			// 5'b100011 : result <= operand_a + operand_b; // subu (this is unimplimented)
			// 5'b100110 : result <= operand_a + operand_b; // xor (this is unimplimented)
			// 5'b001110 : result <= operand_a + operand_b; // xori (this is unimplimented)
			default : result <= 32'hDEADBEEF;
		endcase
	end
endmodule