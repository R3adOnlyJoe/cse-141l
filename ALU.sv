// Create Date:    2016.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2018.01.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			  // includes package "definitions"
module ALU(
  input [ 7:0] INPUTA,      	  // data inputs
               INPUTB,
  input [ 3:0] OP,				  // ALU opcode, part of microcode
  input        SC_IN,             // shift in/carry in 
  output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
  output logic SC_OUT,			  // shift out/carry out
  output logic branch,
  output logic ZERO              // zero out flag
    );
	 
  op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing
	
  always_comb begin
    {SC_OUT, OUT} = 0;
	 branch = 0;// default -- clear carry out and result out
// single instruction for both LSW & MSW
  case(OP)
    KADD : {SC_OUT, OUT} = {1'b0,INPUTA} + INPUTB + SC_IN;  // add w/ carry-in & out
    KLSH : {SC_OUT, OUT} = {INPUTA, SC_IN};  	            // shift left 
	KRSH : {OUT, SC_OUT} = {SC_IN, INPUTA};			        // shift right
//  kRSH : {OUT, SC_OUT} = (INPUTA << 1'b1) | SC_IN;
 	KXOR : begin 
 	         OUT    = INPUTA^INPUTB;  	     			   // exclusive OR
			 SC_OUT = 0;
		   end
    KAND : begin                                           // bitwise AND
             OUT    = INPUTA & INPUTB;
			 SC_OUT = 0;
		   end
    KSUB : begin
	         OUT    = INPUTA + (~INPUTB) + SC_IN;	       // check me on this!
			 SC_OUT = 0;
	       end
	 KDIV : begin
				OUT 	 = INPUTA / INPUTB;
				SC_OUT = 0;
				end
	 KMUL : begin
				OUT  	 = INPUTA * INPUTB;
				SC_OUT = 0;
				end
	 KLOA	: begin
				OUT = INPUTA;
				SC_OUT = 0;
				end
	 
	 KSTR : begin
				OUT = INPUTB;
				SC_OUT = 0;
				end
	 
	 KGETI : begin
				OUT = INPUTA;
				SC_OUT = 0;
				end
	 
	 KGET : begin
				OUT = INPUTA;
				SC_OUT = 0;
				end
	 
	 lookup : begin
				 OUT = INPUTA;
				 SC_OUT = 0;
				 end
	 
    default: begin
				{SC_OUT,OUT} = 0;	
				end// no-op, zero out
  endcase
// option 2 -- separate LSW and MSW instructions
//    case(OP)
//	  kADDL : {SC_OUT,OUT} = INPUTA + INPUTB ;    // LSW add operation
//	  kLSAL : {SC_OUT,OUT} = (INPUTA<<1) ;  	  // LSW shift instruction
//	  kADDU : begin
//	            OUT = INPUTA + INPUTB + SC_IN;    // MSW add operation
//                SC_OUT = 0;   
//              end
//	  kLSAU : begin
//	            OUT = (INPUTA<<1) + SC_IN;  	  // MSW shift instruction
//                SC_OUT = 0;
//               end
//      kXOR  : OUT = INPUTA ^ INPUTB;
//	  kBRNE : OUT = INPUTA - INPUTB;   // use in conjunction w/ instruction decode 
//  endcase
	case(OUT)
	  'b0     : ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase
//$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);					  // displays operation name in waveform viewer
  end											
//    OP == 3'b101; //!INPUTB[0];               
// always_comb	branch_enable = opcode[8:6]==3'b101? 1 : 0;  
endmodule



	   /*
			Left shift

            
			  input a = 10110011   sc_in = 1

              output = 01100111
			  sc_out =	1

							   */