`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    l1_cache 
// Target Devices: Xilinx Spartan 6 - LX9
// Tool versions:  Xilinx ISE 14.7 (64 bit) Linux
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////
module l1_cache(
    output [31:0] read_data,
    input [15:0] read_addr,
    output data_ready,
    input clk,
    input clk_en,
    input rst
    );

	// input
	wire clk_en;

	// outputs
	reg [31:0] read_data;
	reg data_ready;

	// internal variables
	reg [31:0] stored[0:63];
	integer i; // used as iterator
	integer r;

	always @ (posedge clk or negedge rst)
	begin 
		if (rst)
		begin
			read_data = 0;
			for (i = 0; i < 63; i=i+1)
			 	stored[i] = {6'b111111,26'd0}; // no-op
			$readmemh("code/test2.hex",stored,10);
				// stored[i] <= {6'b111111,{26{1'b0}}}; // jump back 5
			// stored[10] <= {6'b001111,5'b0,5'b0,16'd1987}; // loadimm r0
			// stored[11] <= {6'b001111,5'b0,5'd1,16'd2015}; // loadimm r1
			// stored[20] <= {6'b0,5'd1,5'd0,5'd2,5'b0,6'b100010}; // sub
			

			// stored[10] <= {6'b001111,5'b0,5'd2,16'd1}; // loadimm r4
			// stored[12] <= {6'b0,5'd2,5'd5,5'd5,5'b0,6'b100000}; // add
			// stored[15] <= {6'b000010,{23{1'b1}},3'b011}; // jump back 5


			// stored[10] <= 32'h3c0207c3; 
			// stored[12] <= 32'h3c0307df; 
			// stored[15] <= 32'h00622022;
		end
		else if (clk_en)
		begin
			read_data<= stored[read_addr[5:0]]; // temporary
			data_ready <= 1;
			// eventually this will be an actual cache
			// and data_ready will be low sometimes
		end
	end
endmodule
