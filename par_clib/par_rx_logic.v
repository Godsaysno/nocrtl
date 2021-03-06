module par_rx_logic(item_out, write, full, 
		valid, item_in, item_read, busy
		);

	input full;
	
	input valid;
	
	output item_read;
	
	output write;

	output busy;

	input [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] item_in;
	
	output [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] item_out;

	assign item_out = item_in;
	
	assign write = !full & valid;
	
	assign item_read = !full & valid;
	
	assign busy = full;
	
endmodule
