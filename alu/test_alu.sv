`timescale 1ns / 1ps

`include "alu.svh"

module test_alu;

	// Inputs
	reg [31:0] operand_a;
	reg [31:0] operand_b;
	reg [5:0] func;

	wire [3:0] flags;

	reg clk=0;

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

	task testcase(input int a, b, test_func, out);
		operand_a <= a;
		operand_b <= b;
		func <= test_func;
		#20;
		$display("t=%g a = %d b = %d, func = 0b%b, result=%d",$time,operand_a,operand_b,func,result);
		assert (result == out) else $error("Wrong result: expected %d, got %d",out,result);
	endtask : testcase

	int corr;
	initial begin
		// Initialize Inputs
		operand_a = 0;
		operand_b = 0;

		testcase(100, 75, `func_add, 175);
		testcase(1024, 2048, `func_add, 3072);
		testcase(7, 7, `func_sub, 0);
		testcase(99, 1, `func_sub, 98);
		testcase(9999, 9999, `func_sub, 0);
		testcase(9999, -999, `func_sub, (9999+999));
        
        $finish;
	end
   

endmodule

