/*
Module name: instructionReg
Description: store instruction signal
By: Leo Ostiga
Date: 11/17/2023

In: 
	[9:0] D = Data Bus inputs
	ENW , ENR0 , ENR1 = enable inputs
	CLKb = CLK input
	//need to decode the read addresses
	//ENR0 + RDA0 -> Rout0[3:0]
	//need to decode the read addresses
	//ENR1 + RDA1 -> Rout1[3:0]
	//need to decode the write addresses
	//ENW + WRA -> Rin[3:0]
Out:
	[9:0] Q0 = data bus out signals 
	[9:0] Q1 = data bus out signals 

Quick copy:
registerFile(.D(), .ENW() , .ENR0() , .ENR1() , .CLKb(), .WRA() , .RDA0() , .RDA1() , .Q0() , .Q1());
*/

module registerFile (
input logic [9:0] D ,
input logic ENW , ENR0 , ENR1 , CLKb ,
input logic [1:0] WRA , RDA0 , RDA1 ,
output logic [9:0] Q0 , Q1
);

	//ENR1 IS ALWAYS 1'B1
	
	logic [9:0] R0, R1, R2, R3;
	
	//reading data and save to register
	always_ff@(negedge(CLKb))
	begin
		if(ENW) //if write is trigger
		begin
			case(WRA)
				2'b00: R0 <= D;
				2'b01: R1 <= D;
				2'b10: R2 <= D;
				2'b11: R3 <= D;
			endcase
		end
		else
			WRA = 0;
	end
	
	
	always_comb
	begin
		
		case({ENR0, RDA0}) //to Q0
			2'b00: Q0 = R0;
			2'b01: Q0 = R1;
			2'b10: Q0 = R2;
			2'b11: Q0 = R3;
			default: Q0 = 0;
		endcase
		
		case({ENR1, RDA1}) //to Q1
			2'b00: Q1 = R0;
			2'b01: Q1 = R1;
			2'b10: Q1 = R2;
			2'b11: Q1 = R3;
		endcase
	end
	

endmodule
