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

	//ENR1 IS ALWAYS 1'B1
	
	logic [9:0] Reg [3:0];
	
	//reading data and save to register
	always_ff@(negedge(CLKb))
	begin
		if(ENW) //if write is trigger
		begin
			Reg[WRA] <= D;
		end
	end
	
	
	always_comb
	begin
		
		case({ENR0, RDA0}) //to Q0
			{1'b1, 2'b00}: Q0 = Reg[0];
			{1'b1, 2'b01}: Q0 = Reg[1];
			{1'b1, 2'b10}: Q0 = Reg[2];
			{1'b1, 2'b11}: Q0 = Reg[3];
			default: Q0 = 0;
		endcase
		
		case({ENR1, RDA1}) //to Q1
			{1'b1, 2'b00}: Q1 = Reg[0];
			{1'b1, 2'b01}: Q1 = Reg[1];
			{1'b1, 2'b10}: Q1 = Reg[2];
			{1'b1, 2'b11}: Q1 = Reg[3];
		endcase
	end
	

endmodule
