/*
Module name: ALU
Description: multi stage ALU
By: Norman Nguyen & Leo Ostiga
Date: 11/3/2023

In: 
	[N-1:0] OP = opcode
	FN = 
	CLKb = CLK input
	Gin = 
	Gout = 
	Ain = 
	
Out:
	[N-1:0] Q = data bus out signals 

Quick copy:
instructionReg(.Q() , .D(), .CLKb(), .E());
*/

module ALU#(
	parameter N = 10
)
(
  input logic [N-1:0] OP ,
  input logic [3:0] FN ,
  input logic Ain , Gin , Gout , CLKb ,
  output logic [N-1:0] RES
);
	
	parameter ADD = 4'b0010;
	parameter SUB = 4'b0011;
	parameter INV = 4'b0100;
	parameter FLP = 4'b0101;
	parameter AND = 4'b0110;
	parameter OR = 4'b0111;
	
	parameter XOR = 4'b1000;
	parameter LSL = 4'b1001;
	parameter LSR = 4'b1010;
	parameter ASR = 4'b1011;
	
  
  logic [N-1:0] addSubResult; //temp addOrSub 

  fulladder sum(.A(A), .B(B), .Co(ALUControl[0]), .S(addSubResult));
	
	
	
	always_comb begin
		//ALU cases mux
		case(FN)
		
			ADD: RES = addSubResult;
			SUB: RES = addSubResult;
			INV: RES = ~B;
			FLP: RES = ~B;
			AND: RES = A & B; //andOrResult;
			OR: RES = A | B;
			XOR: RES = A ^ B;
			LSL: 
			LSR:
			ASR: 
			
		endcase
	end
	
	
	
endmodule 
