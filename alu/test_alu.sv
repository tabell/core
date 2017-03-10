`timescale 1ns / 1ps

`include "alu.svh"

module test_alu;

	// Inputs
	reg [31:0] operand_a;
	reg [31:0] operand_b;
	reg [5:0] func;

	wire [3:0] flags;

	reg clk=0;
	logic x;

	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.operand_a(operand_a),
		.operand_b(operand_b),
		.result(result),
		.func(func),
		// .clk_en(1),
		.clk(clk),
		.flags(flags)
	);
	always begin
		#10 clk <= ~clk;
	end



	initial begin
		$display("Starting alu testbench");
		$monitor("t=%g a = %d b = %d, func = %d, result=%d",$time,operand_a,operand_b,func,result);
		// Initialize Inputs
		operand_a = 0;
		operand_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
		operand_a <= 100;
		operand_b <= 75;
		func <= `func_add;
		#20;
		// x = testcase(100, 75, `func_add, 175);
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
		#20;
        
        $finish;
		// Add stimulus here

	end
   
	task testcase(output int pass, input int a, b, test_func, out);
		operand_a <= a;
		operand_b <= b;
		func <= test_func;
		#20 $display("a = %d b = %d, func = %x, expected %d, got %d",operand_a,operand_b,func,result,out);
	endtask : testcase

endmodule

