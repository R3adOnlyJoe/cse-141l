// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
	input[ 8:0] Instruction,	   // machine code
	input       ZERO,			   // ALU out[7:0] = 0
	output logic  	MEM_READ,	   // data_memory read enable
	output logic  	MEM_WRITE,	   // data_memory write enable
	output logic	REG_WRITE,	   // reg_file write enable
	output logic  	ACC_WRITE,        // carry reg clear
	output logic  	IS_MEM,	       // carry reg enable
	output logic  	LOOKUP,	       // to carry register
	output logic	branch,
	output logic   done
  );
// jump on right shift that generates a zero
always_comb begin
  if(Instruction[8] == 1'b1) begin
		MEM_READ = 0;
		MEM_WRITE = 0;
		REG_WRITE = 0;
		ACC_WRITE = 0;
		IS_MEM = 0;
		LOOKUP = 0;
		branch = 1;
		done = 0;

	end
	else begin
		case(Instruction[7:4])
			0: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			1: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			2: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			3: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			4: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			5: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			6: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			7: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			8: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			9: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 1;
				ACC_WRITE = 0;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			10: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			11: begin
				MEM_READ = 1;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 1;
				LOOKUP = 0;
				branch = 0;
				done = 0;

			end
			12: begin
				MEM_READ = 0;
				MEM_WRITE = 1;
				REG_WRITE = 0;
				ACC_WRITE = 0;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;

			end
			13: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 0;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 1;
			end
			14: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 1;
				branch = 0;
				done = 0;
			end
			15: begin 
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 1;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
			default: begin
				MEM_READ = 0;
				MEM_WRITE = 0;
				REG_WRITE = 0;
				ACC_WRITE = 0;
				IS_MEM = 0;
				LOOKUP = 0;
				branch = 0;
				done = 0;
			end
		endcase
	end
end
endmodule

   // ARM instructions sequence
   //				cmp r5, r4
   //				beq jump_label