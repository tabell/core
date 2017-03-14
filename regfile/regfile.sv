`timescale 1ns / 1ps
module regfile(
    output reg [31:0] read_data_a,
    output reg [31:0] read_data_b,
    input [31:0] write_data,
    input [4:0] read_addr_a,
    input [4:0] read_addr_b,
    input [4:0] write_addr,
    input write_enable,
    input clk,
    input rst
    );

	reg [31:0] stored[0:31];

	integer i;

	always @ (posedge clk or posedge rst)
	begin 
		if (rst)
		begin
			for (i = 0; i < 32; i=i+1)
				stored[i] <= 0;
		end
		else
		begin
			if (write_enable)
				if (write_addr !== 0) // reg0 reserved
					stored[write_addr] <= write_data;
		end
	end
	always @(*) begin
		read_data_a <= stored[read_addr_a];
		read_data_b <= stored[read_addr_b];
	end
endmodule
