// CSE141L
// program counter
// accepts branch and jump instructions
// default = increment by 1
// issues halt when PC reaches 63
module PC(
  input start,
  input [9:0]start_address,		// relative
  input branch,		// 
  input[7:0]	target,
  input  taken,
		CLK,
		LOOKUP2,
		LOOKUP3,
  output logic[ 9:0] PC);
  
initial begin 
	PC <= 0;
end
always @(posedge CLK)
    if(start)
		PC<=PC+1;
    else if(branch) 
		  if(taken)
		      if(LOOKUP2)
					PC <=5;
				else if(LOOKUP3)
					if(PC<670)
					
						PC <=261; 
					else
						PC<=681;
				else
					PC <= PC+target; 
		  else
				PC <= PC + 1;
		else 
			PC<=PC+1;
	
  
  
endmodule