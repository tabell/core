`timescale 1ns / 1ps

module test_regfile;

	// Inputs
	reg [31:0] write_data;
	reg [4:0] read_addr_a;
	reg [4:0] read_addr_b;
	reg [4:0] write_addr;
	reg write_enable;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] read_data_a;
	wire [31:0] read_data_b;

	// Instantiate the Unit Under Test (UUT)
	regfile uut (
		.read_data_a(read_data_a), 
		.read_data_b(read_data_b), 
		.write_data(write_data), 
		.read_addr_a(read_addr_a), 
		.read_addr_b(read_addr_b), 
		.write_addr(write_addr), 
		.write_enable(write_enable), 
		.clk(clk), 
		.rst(rst)
	);

	task test_write_readback_one_a(input int addr,data);
		write_addr <= addr;
		write_data <= data;
		write_enable <= 1;
		// $display("addr = %u data = %d, wr = %b",addr,data,write_enable);
		#20;
		write_addr <= 0;
		write_data <= 0;
		read_addr_a <= addr;
		write_enable <= 0;
		#20;
		assert(read_data_a == data) 
			else $error("Wrong value read from port a: expected %d got %d",data,read_data_a);
	endtask : test_write_readback_one_a


	// always @(read_data_a) begin
	// 	$display("a[%u] = %d",read_addr_a,read_data_a);
	// end
	// always @(read_data_b) begin
	// 	$display("b[%u] = %d",read_addr_b,read_data_b);
	// end

	initial begin
		// Initialize Inputs
		write_data = 0;
		read_addr_a = 0;
		read_addr_b = 0;
		write_addr = 0;
		write_enable = 0;
		clk = 0;
		rst = 0;
		#20 rst <= 1;
		#20 rst <= 0;
		$display("Reset complete",);

		// Register 0 is reserved (why?)
		for (int i=1; i < 32; i++) begin
			for (int j=1; j < 1024; j++) begin
				test_write_readback_one_a(i,$urandom());
			end
		end
		// Add stimulus here
		$finish;
	end
	always begin
		#10	clk <= ~clk;
	end
	// always @(posedge clk) begin
	// 			$display("t = %g, data_w = %d, addr_w = %u, wr_en = %b || addr_a = %u, addr_b = %u, data_a = %d, data_b = %d",
	// 		$time,write_data,write_addr,write_enable,read_addr_a,read_addr_b,read_data_a,read_data_b);
	// end
      
endmodule

