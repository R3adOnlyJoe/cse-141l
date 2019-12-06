// CSE141L
// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
module LUT(
  input[3:0] addr,
  output logic[7:0] Target
  );

always_comb 
  case(addr)		   //-16'd30;
	4'b0000:   Target = 8'b00000000;//0
	4'b0001:   Target = 8'b00000001;
	4'b0010:   Target = 8'b00011110; //30 
	4'b0011:   Target = 8'b00011111; //31
	
	default: Target = 8'b00000000;
  endcase

endmodule