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
	
	logic [N-1:0] A; //A
	logic [N-1:0] B; //B
	logic [N-1:0] tempRes; //Temp ressult
	logic [9:0] I;
	assign I = OP[5:0];
	
	always_ff@(posedge(Ain))
		A <= OP; //store A
		
	always_ff@(posedge(Gin))
		B <= OP; //store B
  
	logic [N-1:0] flipResult; //flip result 
	logic invA = ~A;
	
	fulladder sum(.A(invA), .B(1), .Co(0), .S(flipResult));
	
	always_comb begin
	
	if(OP[9:8] == 2'b00)
		begin
			//ALU cases mux for OP 00
			case(FN)
			
				ADD: tempRes = A + B;
				SUB: tempRes = A - B;
				INV: tempRes = ~A;
				FLP: tempRes = flipResult;
				AND: tempRes = A & B; //andOrResult;
				OR: tempRes = A | B;
				XOR: tempRes = A ^ B;
				LSL: tempRes = A << B;
				LSR: tempRes = A >> B;
				ASR: tempRes = A >>> B;
				
				default: 
					tempRes = 10'd0;
			endcase
			end
			
	else if(OP[9:8] == 2'b10)
		begin
			tempRes = A + I;
		end
		
	else if(OP[9:8] == 2'b11)
		begin
			tempRes = A - I;
		end
		
	else
		tempRes = 10'd0;
			
	end
	
	
	always_ff@(negedge (CLKb)) //send out result
		if(Gout)
			RES <= tempRes;
		else
			RES <= 10'd0;
	
	
	
endmodule 
