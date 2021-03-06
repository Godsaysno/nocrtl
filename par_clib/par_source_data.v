
module par_source_from_memory (clk, reset, item_out, valid, busy, send);
	parameter id = -1;
	
	parameter dests = 1;
	
	parameter pir=16;
	
	parameter traffic_file = "";
	
	input clk, reset, busy, send;
		
	output [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] item_out;
	
	output valid;

	wire [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] data;
	
	source_from_memory #(id, dests, pir, traffic_file) s1 (clk, reset, data, req, busy, send);
	
	assign item_out = data;
	
	assign valid = req;
	
endmodule


module source_from_memory (clk, reset, data, req, busy, send);

	parameter id = -1;
	
	parameter dests = 1;
	
	parameter pir=16;
	
	parameter traffic_file = "";
	
	parameter msg_size = 12																																																																																																																																																																																																																																																																																																																																																																																																													;
	
	input clk, reset, busy, send;
	
	output req;
	
	output [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] data;
	
	reg [`HDR_SZ + `PL_SZ + `ADDR_SZ-1:0] data;
	
	reg counter;
	
	reg req;

	reg pause;

	reg done;
	
	reg fire; 
	
	reg [3:0] index;
	
	reg [3:0] dindex;
	
	reg [7:0] rand;
	
	reg [`ADDR_SZ-1:0] memory [0:`NUM_NODES-1];
	reg [`PL_SZ-1:0] dmemory [0:msg_size-1];
	
	initial $readmemh(traffic_file, memory, 0, dests-1) ;
	initial $readmemh("data2.hex", dmemory, 0, msg_size-1) ;
	
	wire [`ADDR_SZ-1:0] dest;
	
	assign dest=memory[index];

	wire can_send;
	
	assign can_send =!(pause | busy);
	
	always @(posedge clk or posedge reset) begin
	
		if (reset) begin
			
			data <= 0;
			
			fire<=1; 
			
			req <= 0;
			
			pause <= 0;
			
			counter <= 1;
			
			index <= 0;
			
			dindex <= 0;
			
			done <= 0;
			
		end 
		else begin
		      
		rand<=$random;
		
	        if (!busy & req) $display ("##,tx,%d,%d",data[`ADDR_SZ-1:0],id);
 	
		if (pause) pause <=0;
		      	      
       		if (can_send & send & !done) begin
// 		if (can_send & send) begin
			  
			  if (fire) begin			
				    if ( id==0 & dest != id ) begin
					  
					  data[`ADDR_SZ-1:0] <= dest;

					  data[`PL_SZ + `ADDR_SZ-1:`ADDR_SZ] <= dmemory[dindex];
				    
					  req <= 1;
					  
					  pause <=1;
					  
					  if (id != -1) $display ("source %d -> %d: %c", id, dest, dmemory[dindex]);
				    
				    end
											  
				      counter <= counter + 1;
					  
				      index <= index + 1;
				      
				    
				    if (index == dests-1) begin
					
					index <=0;
					
					dindex <= dindex + 1;
					
					if (dindex == msg_size-1) done <= 1;
					
				    end
				  
			  end
				  
		  end // busy
		  else begin

		      req <= 0;
		  end
		  fire <= 1; //(rand < pir);
			
		end //else reset
	
	end // always

endmodule
