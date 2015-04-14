`timescale 1ns / 1ps

module core(
	input clk,
	input rst,
	input clk_en
);

alu alu1(
	.operand_a(alu_operand_a),
	.operand_b(alu_operand_b),
	.func(alu_func),
	.result(alu_result),
	.clk(clk),
	.clk_en(alu_clk_en)
	);

wire [31:0] regfile_read_data_a;
wire [31:0] regfile_read_data_b;
wire [31:0] regfile_write_data;
wire [4:0] regfile_read_addr_a;
wire [4:0] regfile_read_addr_b;
wire [4:0] regfile_write_addr;
wire regfile_write_enable;
regfile regfile(
    .read_data_a(regfile_read_data_a),
    .read_data_b(regfile_read_data_b),
    .write_data(regfile_write_data),
    .read_addr_a(regfile_read_addr_a),
    .read_addr_b(regfile_read_addr_b),
    .write_addr(regfile_write_addr),
    .write_enable(regfile_write_enable),
    .clk(clk),
    .rst(rst)
    );

	wire clk;
	reg tmp=0;

	reg [15:0] pc; // program counter
	reg [15:0] n_pc; // next program counter

always @(posedge clk) begin
	if(rst) begin
		pc <= 10; // start address 10 so maybe interrupts later?
		n_pc <= 11;
		tmp <= 0;
	end else if(clk_en) begin
		pc <= n_pc;
		n_pc <= n_pc + 1;
		tmp <= tmp + 1;
	end
end

    
endmodule