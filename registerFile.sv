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
registerFile(.D(), .ENW() , .ENR0() , .ENR1() , .CLKb(), .WRA() , .RDA0() , .RDA1());
*/

module registerFile (
input logic [9:0] D ,
input logic ENW , ENR0 , ENR1 , CLKb ,
input logic [1:0] WRA , RDA0 , RDA1 ,
output logic [9:0] Q0 , Q1
);

	//ENR1 IS ALWAYS 1'B1
	//logic [3:0] Rout;
	always_comb
	begin
		case ({ENR, RDA})
			000,
			001,
			010,
			011: Rout = 'h0;
	end
	
	

endmodule