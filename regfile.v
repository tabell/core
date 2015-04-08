`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:28 04/07/2015 
// Design Name: 
// Module Name:    regfile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module regfile(
    output [31:0] read_data_a,
    output [31:0] read_data_b,
    input [31:0] write_data,
    input [4:0] read_addr_a,
    input [4:0] read_addr_b,
    input [4:0] write_addr,
    input write_enable,
    input clk,
    input rst
    );

	reg [31:0] stored[0:31];
	reg [31:0] read_data_a;
	reg [31:0] read_data_b;

	integer i;

	always @ (posedge clk)
	begin 
		if (rst)
		begin
			read_data_a <= 0;
			read_data_b <= 0;
			for (i = 0; i < 32; i=i+1)
				stored[i] <= 0;
		end
		else
		begin
			if (write_enable)
				stored[write_addr] <= write_data;
			read_data_a <= stored[read_addr_a];
			read_data_b <= stored[read_addr_b];
		end
	end
endmodule
