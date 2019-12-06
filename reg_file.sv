// Create Date:    2017.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file #(parameter W=8, D=4)(		 // W = data path width; D = pointer width
  input           CLK,
                  REG_WRITE,
						ACC_WRITE,
						imme_value,
  input  [ D-1:0] reg_index,
  input  [ W-1:0] data_in,

  output [ W-1:0] ACC_OUT,
  output logic [W-1:0] REG_OUT
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0
assign      REG_OUT =imme_value?{4'b0000,reg_index}: reg_index? registers[reg_index] : '0;	 // can't read from addr 0, just like MIPS
assign	   ACC_OUT = registers[0];               // can read from addr 0, just like ARM

// sequential (clocked) writes 
always_ff @ (posedge CLK)
  if (ACC_WRITE )	                             // && waddr requires nonzero pointer address
// if (write_en) if want to be able to write to address 0, as well
    registers[0] <= data_in;
	else if(REG_WRITE)
		registers[reg_index] =data_in;

endmodule
