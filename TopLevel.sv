// Create Date:    2018.04.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
    input     start,	   // init/reset, active high
	input     CLK,		   // clock -- posedge used inside design
    output    done		   // done flag from DUT
    );

wire [ 9:0] PC;            // program count
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] ReadA, ReadR;  // reg_file outputs
wire [ 7:0] InA, InB, 	   // ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] regWriteValue, // data in to reg file
            memWriteValue, // data in to data_memory
	   	    Mem_Out,	   // data out from data_memory
				 lookupValue,
				 target;
wire        MEM_READ,	   // data_memory read enable
		    MEM_WRITE,	   // data_memory write enable
			reg_wr_en,	   // reg_file write enable
			ACC_WRITE,        // carry reg clear
			IS_MEM,	       // carry reg enable
			REG_WRITE,
		    LOOKUP,	       // to carry register
			 LOOKUP2,
			ZERO,		   // ALU output = 0 flag
            taken,	   // to program counter: jump enable
				SC_IN,
				SC_OUT,
            branch;	   // to program counter: branch enable
				
logic[15:0] cycle_ct;	   // standalone; NOT PC!
logic [$clog2(512):0] start_address;
// Fetch = Program Counter + Instruction ROM
// Program Counter
  PC PC1 (
   .start,
   .start_address,		// relative
	.branch,		// 
	.target(Instruction[7:0]),
	.taken,
	.LOOKUP2,
	.PC,
	.CLK
	);
  
  
// instruction ROM
  InstROM instr_ROM1(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);

// Control decoder
  Ctrl Ctrl1 (
	.Instruction,    // from instr_ROM
	.ZERO,			 // from ALU: result = 0
	.MEM_READ,	   // data_memory read enable
	.MEM_WRITE,	   // data_memory write enable
	.REG_WRITE,	   // reg_file write enable
	.ACC_WRITE,        // carry reg clear
	.IS_MEM,	       // carry reg enable
	.LOOKUP,	       // to carry register
	.LOOKUP2,
	.branch,
	.done
  );
  

	LUT lookup_table(
	.addr(Instruction[3:0]),
	.Target(lookupValue)
	);
  assign load_inst = Instruction[7:4]==4'b1011;  // calls out load specially
  assign imme_value = Instruction[7:4]== 4'b0111;
// reg file
	reg_file #(.W(8),.D(4)) reg_file1 (
	 .CLK,
    .REG_WRITE,
	 .ACC_WRITE,
	 .reg_index(Instruction[3:0]),
	 .data_in(LOOKUP?lookupValue:regWriteValue),
    .ACC_OUT(ReadA),
	 .REG_OUT(ReadR),
	 .imme_value
	);
// one pointer, two adjacent read accesses: (optional approach)
//	.raddrA ({Instruction[5:3],1'b0});
//	.raddrB ({Instruction[5:3],1'b1});

   assign InA = ReadA;						          // connect RF out to ALU in
	assign InB = ReadR;
	//assign MEM_WRITE = (Instruction == 9'h111);       // mem_store command
	assign regWriteValue = load_inst? Mem_Out : ALU_out;  // 2:1 switch into reg_file
    ALU ALU1  (
	  .INPUTA  (InA),
	  .INPUTB  (InB), 
	  .OP      (Instruction[7:4]),
	  .OUT     (ALU_out),//regWriteValue),
	  .SC_IN   ,//(SC_IN),
	  .SC_OUT  ,
	  .IS_BRANCH(Instruction[8]||Instruction[7:4]==4'b0011),
	  .branch(taken)  ,
	  .ZERO 
	  );
  
	data_mem data_mem1(
		.DataAddress  (ALU_out)    , 
		.ReadMem      (MEM_READ),          //(MEM_READ) ,   always enabled 
		.WriteMem     (MEM_WRITE), 
		.DataIn       (ReadA), 
		.DataOut      (Mem_Out)  , 
		.CLK 		  		     ,
		.reset		  (start)
	);
	
// count number of instructions executed
always_ff @(posedge CLK)
  if (start == 1)	  begin // if(start)
  	cycle_ct <= 0;
	start_address <= 0;
	end
	
  else if(done == 0)   // if(!halt)
  	cycle_ct <= cycle_ct+16'b1;


endmodule