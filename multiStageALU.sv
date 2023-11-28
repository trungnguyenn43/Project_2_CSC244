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
	logic [N-1:0] B; //B
	logic [N-1:0] G; //Temp ressult
	
	always_ff@(negedge(Ain))
		A <= OP; //store A
		
	always_comb begin
	if(Gin)
		begin
		//ALU cases mux for OP 00
		case(FN)
		
			ADD: G = A + B;
			SUB: G = A - B;
			INV: G = (~A) + 1;
			FLP: G = ~A;
			AND: G = A & B;
			OR: G = A | B;
			XOR: G = A ^ B;
			LSL: G = A << B;
			LSR: G = A >> B;
			ASR: G = A >>> B;
			
			default: 
				G = 10'd0;
		endcase
			
			
		if(OP[9:8] == 2'b10)
			begin
				G = A + OP[5:0];
			end
			
		else if(OP[9:8] == 2'b11)
			begin
				G = A - OP[5:0];
			end
			
		else
			G = 10'd0;
		end
	end
	
	always_comb //send out result
		if(Gout)
			RES <= G;
		else
			RES <= 10'd0;
	
	
	
endmodule 
