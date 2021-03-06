
module gray_counter (
  out    , // counter out
  en , // enable for counter
  clk    , // clock
  rst      // active hight reset
  );
  parameter width=8;
  //------------Input Ports--------------
  input clk, rst, en; 
  output [ width-1:0] out;
  wire [width-1:0] out;
  reg [width-1:0] count;

  
  always @ (posedge clk) 
  if (rst) count <= 0; 
  else if (en) 
    count <= count + 1; 
 
 integer i;
 
  assign out = { count[7], (count[7] ^ count[6]),(count[6] ^ 
               count[5]),(count[5] ^ count[4]), (count[4] ^ 
               count[3]),(count[3] ^ count[2]), (count[2] ^ 
               count[1]),(count[1] ^ count[0]) };
    
endmodule 
