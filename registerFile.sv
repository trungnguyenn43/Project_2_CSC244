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
		output logic [9:0] Q0 ,
		output logic [9:0] Q1
);

	logic [9:0] Reg [3:0]; //4 10-bit registers
	
	// Saving data to register
	always_ff@(negedge(CLKb))
	begin
		if(ENW) //if write is enabled
		begin
			Reg[WRA] <= D; //write to register @ address
		end
	end
	// Reading data from register
	always_comb begin
		if(ENR0) //if read is enabled
			Q0 = Reg[RDA0]; //read from register @ address
		else
			Q0= 10'bz;
		if(ENR1) //ENR1 is always on
			Q1= Reg[RDA1]; //read from register @ address
		else
			Q1= 10'bz;
	end		
	
endmodule
