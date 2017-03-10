`timescale 1ns / 1ps
`default_nettype none

module core(
	input clk,
	input rst,
	input clk_en
);

wire rst;
wire clk_en;

wire [31:0] icache_read_data;
reg [5:0] icache_read_addr;
wire icache_data_ready;
reg icache_clk_en;

l1_cache icache(
	.read_data(icache_read_data),
	.read_addr(pc[5:0]),
	.data_ready(icache_data_ready),
	.clk(clk),
	.clk_en(icache_clk_en),
	.rst(rst)
	);

wire [31:0] alu_operand_a;
reg [31:0] alu_operand_b_mux;
reg [31:0] alu_operand_a_mux;
reg [5:0] alu_func_mux;
wire [31:0] alu_result;
reg alu_clk_en;

alu alu1(
	.operand_a(alu_operand_a_mux),
	.operand_b(alu_operand_b_mux),
	.result(alu_result),
	.func(alu_func_mux),
	.clk(clk),
	.clk_en(alu_clk_en)
	);

wire [31:0] regfile_read_data_a;
wire [31:0] regfile_read_data_b;
reg [31:0] regfile_write_data;
reg [4:0] regfile_write_addr;
reg regfile_write_enable;

regfile regfile(
    .read_data_a(regfile_read_data_a),
    .read_data_b(regfile_read_data_b),
    .write_data(regfile_write_data),
    .read_addr_a(decode_reg_s),
    .read_addr_b(decode_reg_t),
    .write_addr(regfile_write_addr),
    .write_enable(regfile_write_enable),
    .clk(clk),
    .rst(rst)
    );

	wire clk;
	reg tmp=0;

	reg [15:0] pc; // program counter
	reg [15:0] n_pc; // next program counter


	reg [5:0]  exec_opcode;
	reg [15:0] exec_imm;
	reg [4:0]  exec_reg_t;
	reg [4:0]  exec_reg_d;
	reg [5:0]  exec_func;

	reg [5:0]  wb_opcode;
	reg [15:0] wb_imm;
	reg [4:0]  wb_reg_t;


always @(posedge clk or posedge rst) begin
	if(rst) begin
		// reset PC
		pc <= 0; // start address 10 so maybe interrupts later?
		n_pc <= 10;

		// clock enables
		icache_clk_en <= 0;
		alu_clk_en <= 0;

	end else if(clk_en) begin
		// clock enables
		icache_clk_en <= 1;
		alu_clk_en <= 1;

		// fetch stage
		
		// on every cycle
		// set new PC
		if (decode_opcode == 2)
			n_pc <= n_pc + decode_sign_imm[15:0];
		else
			n_pc <= n_pc + 1;
		pc <= n_pc;

		// execute
		regfile_write_enable <= 0;
		regfile_write_addr <= 5'hZ;

		exec_opcode <= decode_opcode;
		exec_reg_t <= decode_reg_t;
		exec_reg_d <= decode_reg_d;
		exec_imm <= decode_imm;
		exec_func <= decode_func;

		// writeback
		wb_imm <= exec_imm;
		wb_opcode <= exec_opcode;
		wb_reg_t <= exec_reg_t;
		
		if (exec_opcode == 15) begin // load immediate hi
			regfile_write_addr <= exec_reg_t;
			regfile_write_enable <= 1;
			regfile_write_data <= {exec_imm,{16{1'b0}}};
		end else if (exec_opcode == 0) begin
			if (exec_reg_d == 0) // dest reg 0 = no-op
				regfile_write_enable <= 0;
			else begin
				regfile_write_enable <= 1;
				regfile_write_addr <= exec_reg_d;
				regfile_write_data <= alu_result;
			end
		end else if (exec_opcode == 8) begin // add immediate
			regfile_write_enable <= 1;
			regfile_write_addr <= exec_reg_t;
			regfile_write_data <= alu_result;
		end
	end
end

wire [5:0] decode_opcode = icache_read_data[31:26];
wire [4:0] decode_reg_s = icache_read_data[25:21]; // source a
wire [4:0] decode_reg_t = icache_read_data[20:16]; // source b
wire [4:0] decode_reg_d = icache_read_data[15:11]; // dest
wire [4:0] decode_shamt = icache_read_data[10:6]; // shift amount
wire [5:0] decode_func = icache_read_data[5:0]; // alu function
wire [15:0] decode_imm = icache_read_data[15:0];
wire [31:0] decode_sign_imm = {{16{icache_read_data[15]}},icache_read_data[15:0]};
wire [25:0] decode_full_imm = icache_read_data[25:0];
wire [31:0] decode_sign_full_imm = {{6{icache_read_data[25]}},icache_read_data[25:0]};

always @(*) begin
	// switches ALU input b betwen regfile output and
	// decoded immediate value
	case (decode_opcode)
		8 : begin
				alu_operand_b_mux <= decode_sign_imm; // add immediate
				alu_operand_a_mux <= regfile_read_data_a;
			end
		0 : begin
				alu_operand_b_mux <= regfile_read_data_b;
				case (decode_func)
					0 : alu_operand_a_mux <= decode_shamt;
					2 : alu_operand_a_mux <= decode_shamt;
					3 : alu_operand_a_mux <= decode_shamt;
					4 : alu_operand_a_mux <= regfile_read_data_a;
					6 : alu_operand_a_mux <= regfile_read_data_a;
					7 : alu_operand_a_mux <= regfile_read_data_a;
				default : alu_operand_a_mux <= regfile_read_data_a;
				endcase
			end
		default : alu_operand_b_mux <= regfile_read_data_b;
	endcase

	// 

	// switches alu func input between decoded
	// func and decoded opcode
	case (decode_opcode)
		0 :	alu_func_mux <= decode_func;
		default : alu_func_mux <= decode_opcode;
	endcase
end
endmodule