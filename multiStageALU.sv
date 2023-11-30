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
	logic [N-1:0] _RES; //temp result
	//logic [9:0] _FN;
	//reg10 storeA(.Q(A), .D(OP), .E(Ain), .CLKb(CLKb));
	//reg10 storeG(.Q(_G), .D(_RES), .E(Gin), .CLKb(CLKb));
	//reg10 gout(.Q(RES), .D(_G), .E(Gout), .CLKb(CLKb));
	
	always_ff@(negedge(CLKb))
		if(Ain)
			A <= OP; //store A
		else
			A <= A;
			
	always_comb 
	begin
		
		//temp= 10'dz;
		//ALU cases mux for OP 00
		case(FN)
			
			ADD: _RES = A + OP;
			SUB: _RES = A - OP;
			INV: _RES = (~A) + 1;
			FLP: _RES = ~A;
			AND: _RES = A & OP;
			OR: _RES = A | OP;
			XOR: _RES = A ^ OP;
			LSL: _RES = A << OP;
			LSR: _RES = A >> OP;
			ASR: _RES = $signed(A) >>> OP;
			
			default: _RES = 10'bz;
			
		endcase	
	end
	
	always_ff@(negedge(CLKb))
		if(Gin)
			G <= _RES;
		else
			G <= G;
	
	always_comb //send out result
		if(Gout == 1'b1)
			RES = G;
		else
			RES = 10'dz;
	
endmodule 
