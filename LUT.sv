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
	4'b0100:	  Target = 8'b01000000; //64
	4'b0101:	  Target = 8'b01000001; //65
	4'b0110:	  Target = 8'b01011110; //94
	4'b0111:	  Target = 8'b01011111; //95
	default: Target = 8'b00000000;
  endcase

endmodule