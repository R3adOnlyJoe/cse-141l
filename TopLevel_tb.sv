// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module TopLevel_tb;	     // Lab 17

// To DUT Inputs
  bit start;
  bit CLK;

// From DUT Outputs
  wire done;		   // done flag

// Instantiate the Device Under Test (DUT)
  TopLevel DUT (
	.start           , 
	.CLK             , 
	.done             
	);

	logic signed[15:0] OpA, OpB;
	int Product;
initial begin
  start = 1;
// Initialize DUT's data memory
  #10ns for(int i=0; i<256; i++) begin
 DUT.data_mem1.core[i] = 8'h0;	     // clear data_mem
    /*DUT.data_mem1.core[1] = 9'h03;      // MSW of operand A
    DUT.data_mem1.core[2] = 9'hff;
    DUT.data_mem1.core[3] = 9'hff;      // MSW of operand B
    DUT.data_mem1.core[4] = 9'hfb;*/
  end
// students may also pre_load desired constants into data_mem
OpA = ($random) >> 16;
OpB = ($random) >> 16;
$display(OpA,,,OpB);
for(int i=0; i<15; i++) begin 
/*	DUT.data_mem1.core[2*i+1] = 8'b00000101;
	DUT.data_mem1.core[i*2] = 8'b01010101;*/
	DUT.data_mem1.core[2*i+1] = {5'b0, {$random} % 8};
	DUT.data_mem1.core[i*2] = {$random} >> 8;
end
/*DUT.data_mem1.core[2] = OpA[7:0];
DUT.data_mem1.core[3] = OpB[15:8];
DUT.data_mem1.core[4] = OpB[7:0];
*/
// Initialize DUT's register file
  for(int j=0; j<16; j++)
    DUT.reg_file1.registers[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file
    
	
// launch program in DUT
  #10ns start = 0;
// Wait for done flag, then display results
  wait (done);
  #10ns for(int i=0; i<15; i++) begin
				$displayh(DUT.data_mem1.core[2*i],
                  DUT.data_mem1.core[2*i+1],"_",
                  DUT.data_mem1.core[30+2*i],
                  DUT.data_mem1.core[30+2*i+1]);
			 end
			Product = OpA * OpB;
			$displayh("bench_rslt = ", Product[31:16],,Product[15:0]);
        $display("instruction = %d %t",DUT.PC,$time);
  #10ns $stop;			   
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end
      
endmodule