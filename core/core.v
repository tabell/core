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
wire [31:0] alu_result;
reg alu_clk_en;

alu alu1(
	.operand_a(alu_operand_a),
	.operand_b(alu_operand_b),
	.result(alu_result),
	.func(decode_func),
	.clk(clk),
	.clk_en(alu_clk_en)
	);

wire [31:0] regfile_read_data_a;
wire [31:0] regfile_read_data_b;
reg [31:0] regfile_write_data;
reg [4:0] regfile_write_addr;
reg regfile_write_enable;

reg regfile_write_data_mux;

regfile regfile(
    .read_data_a(alu_operand_a),
    .read_data_b(alu_operand_b),
    .write_data(regfile_write_data),
    .read_addr_a(icache_read_data[25:21]),
    .read_addr_b(icache_read_data[20:16]),
    .write_addr(regfile_write_addr),
    .write_enable(regfile_write_enable),
    .clk(clk),
    .rst(rst)
    );

	wire clk;
	reg tmp=0;

	reg [15:0] pc; // program counter
	reg [15:0] n_pc; // next program counter

	reg [5:0] decode_opcode;
	reg [4:0] decode_reg_s;
	reg [4:0] decode_reg_t;
	reg [4:0] decode_reg_d;
	reg [4:0] decode_shamt;
	reg [5:0] decode_func;
	reg [15:0] decode_imm;

	reg [5:0]  exec_opcode;
	reg [15:0] exec_imm;
	reg [4:0]  exec_reg_t;
	reg [5:0]  exec_func;

	reg [5:0]  wb_opcode;
	reg [15:0] wb_imm;


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
		icache_read_addr <= n_pc;

		// execute
		regfile_write_enable <= 0;
		regfile_write_addr <= 5'hZ;

		exec_opcode <= decode_opcode;
		if (decode_opcode == 15) begin // load immediate hi
			exec_reg_t <= decode_reg_t;
			exec_imm <= decode_imm; // TODO: this is actually supposed to be shifted left 16 bits
		end

		if (exec_opcode == 15) begin // load immediate hi
			regfile_write_addr <= exec_reg_t;
			// regfile_write_data <= exec_imm; // TODO: this is actually supposed to be shifted left 16 bits
			regfile_write_enable <= 1;
		end else if (exec_opcode == 0) begin
			if (decode_reg_d == 0)
				regfile_write_enable <= 0;
			else begin
				// regfile_write_data <= alu_result;
				regfile_write_enable <= 1;
				regfile_write_addr <= decode_reg_d;
			end
		end

		wb_imm <= exec_imm;
		wb_opcode <= exec_opcode;

	end
end


always @(*) begin : proc_decoder
	assign decode_opcode = icache_read_data[31:26];
	assign decode_imm = icache_read_data[15:0];
	assign decode_reg_s = icache_read_data[25:21]; // source a
	assign decode_reg_t = icache_read_data[20:16]; // source b
	assign decode_reg_d = icache_read_data[15:11]; // dest
	assign decode_shamt = icache_read_data[10:6]; // shift amount
	assign decode_func = icache_read_data[5:0]; // shift amount
	// if (exec_opcode == 0)
	// 	assign regfile_write_data = alu_result;
	if (wb_opcode == 0)
		assign regfile_write_data = alu_result;
	else if (wb_opcode == 15)
		assign regfile_write_data = wb_imm;
	else
		assign regfile_write_data = 0'h777;
end
    
endmodule