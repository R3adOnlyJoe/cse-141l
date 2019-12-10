// CSE141L
// program counter
// accepts branch and jump instructions
// default = increment by 1
// issues halt when PC reaches 63
module PC(
  input start,
  input [$clog2(512):0]start_address,		// relative
  input branch,		// 
  input[7:0]	target,
  input  taken,
		CLK,
		LOOKUP2,
  output logic[ 9:0] PC);

always @(posedge CLK)
  if(start) begin
    PC <= 0;
  end
  else begin
    if(branch) begin
		  if(taken)
		      if(LOOKUP2)
					PC <=target[3:0];
				else
					PC <= PC+target; 
		  else
				PC <= PC + 1;
		end	
	  else 
			PC <= PC + 1; // just a randomly chosen number 
  end
  
endmodule