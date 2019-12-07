//This file defines the parameters used in the alu
// CSE141L
package definitions;
    
// Instruction map
   /* const logic [2:0]kADD  = 3'b000;
    const logic [2:0]kLSH  = 3'b001;
    const logic [2:0]kRSH  = 3'b010;
    const logic [2:0]kXOR  = 3'b011;
    const logic [2:0]kAND  = 3'b100;
	const logic [2:0]kSUB  = 3'b101;
	const logic [2:0]kCLR  = 3'b110;
	*/
	const logic [3:0]KSUB = 4'b0000;
	const logic [3:0]KADD = 4'b0001;
	const logic [3:0]KDIV = 4'b0010;
	const logic [3:0]KMUL = 4'b0011;
	const logic [3:0]KXOR = 4'b0100;
	const logic [3:0]KLSH = 4'b0101;
	const logic [3:0]KRSH = 4'b0110;
	const logic [3:0]KGETI = 4'b0111;
	const logic [3:0]KAND = 4'b1000;
	const logic [3:0]KSET = 4'b1001;
	const logic [3:0]KGET = 4'b1010;
	const logic [3:0]KLOA = 4'b1011;
	const logic [3:0]KSTR = 4'b1100;
	const logic [3:0]done = 4'b1101;
	const logic [3:0]lookup = 4'b1110;
	const logic [3:0]kor = 4'b1111;


// enum names will appear in timing diagram

    typedef enum logic[3:0] {
        SUB,ADD, DIV,MUL,XOR,LSH, RSH, GETI,
        AND, SET,GET,LOA,STR,don,look,OR} op_mne;
// note: kADD is of type logic[3:0] (4-bit binary)
//   ADD is of type enum -- equiv., but watch casting
//   see ALU.sv for how to handle this   
endpackage // definitions
