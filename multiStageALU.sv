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
MultiStageALU(.RES(), .Ain(), .Gin(), .Gout(), .CLKb(), .FN(), .OP());
*/

module MultiStageALU#(
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
	
	logic [N-1:0] A; //A
	logic [N-1:0] G; //ressult
	logic [N-1:0] temp; //temp ressult
	
	//assign B = OP;
	
	always_ff@(negedge(CLKb))
		if(Ain)
			A <= OP; //store A
		else
			A <= A;
		
	always_comb 
	begin
	
		//ALU cases mux for OP 00
		temp= 10'b0;
		case(FN)
			
			ADD: temp = A + OP;
			SUB: temp = A - OP;
			INV: temp = (~A) + 1;
			FLP: temp = ~A;
			AND: temp = A & OP;
			OR: temp = A | OP;
			XOR: temp = A ^ OP;
			LSL: temp = A << OP;
			LSR: temp = A >> OP;
			ASR: temp = $signed(A) >>> OP;
			
			default: temp = 10'bZZZZZZZZZZ;
		endcase	
	end
	
	//save result
	always_ff@(negedge(CLKb))
		if(Gin)
			G <= temp;
		else
			G <= G;
	
	always_comb //send out result
		if(Gout)
			RES = temp;
		else
			RES = 10'bz;
	
	
	
endmodule 
