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
    output [31:0] read_data,
    input [31:0] write_data,
    input [4:0] read_addr,
    input [4:0] write_addr,
    input write_enable,
    input clk,
    input rst
    );

	reg [31:0] stored[31:0];

	// always @ posedge(clk)
	// read_data <= stored

endmodule
