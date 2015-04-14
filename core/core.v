`timescale 1ns / 1ps

module core(
	input clk,
	input rst,
	input clk_en
);

wire [31:0] icache_read_data;
reg [5:0] icache_read_addr;
wire icache_data_ready;
reg icache_clk_en;

l1_cache icache(
	.read_data(icache_read_data),
	.read_addr(icache_read_addr),
	.data_ready(icache_data_ready),
	.clk(clk),
	.clk_en(icache_clk_en),
	.rst(rst)
	);

wire [31:0] alu_operand_a;
wire [31:0] alu_operand_b;
wire [5:0] alu_func;
wire [31:0] alu_result;
reg alu_clk_en;

alu alu1(
	.operand_a(alu_operand_a),
	.operand_b(alu_operand_b),
	.result(alu_result),
	.func(alu_func),
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

always @(posedge clk or negedge rst) begin
	if(rst) begin
		// reset PC
		pc <= 0; // start address 10 so maybe interrupts later?
		n_pc <= 10;

		// clock enables
		icache_clk_en <= 0;
		alu_clk_en <= 0;

	end else if(clk_en) begin
		// on every cycle
		// set new PC
		pc <= n_pc;
		n_pc <= n_pc + 1;
		// clock enables
		icache_clk_en <= 1;
		alu_clk_en <= 1;

		// fetch stage
		icache_read_addr <= pc;
	end
end

reg [5:0] decode_opcode;
reg [4:0] decode_reg_s;
reg [4:0] decode_reg_t;
reg [4:0] decode_reg_d;
reg [10:0] decode_func;
reg [15:0] decode_imm;
always @(*) begin : proc_decoder
	decode_opcode <= icache_read_data[31:26];
	decode_reg_s  <= icache_read_data[25:21];
	decode_reg_t  <= icache_read_data[20:16];
	decode_reg_d  <= icache_read_data[15:11];
	decode_func  <= icache_read_data[10:0];
	decode_imm  <= icache_read_data[15:0];
end
    
endmodule