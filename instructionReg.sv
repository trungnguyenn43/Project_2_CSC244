/*
Module name: instructionReg
Description: store instruction signal
By: Leo Ostiga
Date: 11/3/2023

In: 
	[N-1:0] D = Data Bus inputs
	E (Enable) = Enable input
	CLKb = CLK input

Out:
	[N-1:0] Q = data bus out signals 

Quick copy:
instructionReg(.Q() , .D(), .CLKb(), .E());
*/

module instructionReg#(
	parameter N = 10 //variable width register
)
(
	input logic [N-1:0] D, 
	input logic CLKb, E,
	output logic [N-1:0] Q
);

	always_ff@(negedge CLKb)
	begin 
		if(E)
			Q <= D;
		else
			Q <= Q;
	end
endmodule