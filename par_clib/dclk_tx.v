
module dclk_tx (clk, reset, req, tx_busy, channel_busy, parallel_in, serial_out, tx_active);

	parameter routerid=-1;
	parameter port="unknown";

	input clk, reset, req, channel_busy;
	
	output tx_busy, serial_out;
	
	input [`PAYLOAD_SIZE+`ADDR_SZ-1:0] parallel_in;
	
	output reg tx_active;
	
	reg [`PAYLOAD_SIZE+`ADDR_SZ+1:0] item;
	
	reg [`PAYLOAD_SIZE+`ADDR_SZ-1:0] temp;
	
	reg [1:0] busy_reg;
	
	wire busy_sync;
	
	assign busy_sync = busy_reg[1];
	
	
	assign serial_out = item[0] & tx_active;
	
	assign tx_busy = tx_active | busy_sync;
	
	always @(posedge clk) begin
	
		if (reset) begin
		
			item <= 0;
			tx_active <= 0;
			temp <= 0;
			busy_reg<=0;
		
		end else begin
			busy_reg[0] <= channel_busy;  // synchronise "channel_busy" to clk
			busy_reg[1] <= busy_reg[0];
			
			if (!tx_active) begin
			
				if (!busy_sync & req) begin
				
					// switch to 'transmitting' state
			
					tx_active <= 1;
					
					item[`PAYLOAD_SIZE+`ADDR_SZ:1] <= parallel_in;
					temp <= parallel_in;
					item[`PAYLOAD_SIZE+`ADDR_SZ+1] <= 1;
					item[0] <= 1;
					
					//if (!tx_active && (routerid > -1)) $display("router %d %s tx : %d", routerid, port, parallel_in);
					
					//item <= {1'b1, parallel_in[`ADDR_SZ-1:0], 1'b1}; // leading one is the start bit of the flit
					
				end
			
			end else begin

				item <= (item >> 1);
				
				if ((item>>1) == 1) begin  // the last (stop bit) ?
					
					// end transmission when the currently transmitted bit is the last
					
					tx_active <= 0;
					item <= 0;
				end
			
			end
		
		end
	
	end

endmodule
