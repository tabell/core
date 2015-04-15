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
			$readmemh("code/test1.hex",stored,10);
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
