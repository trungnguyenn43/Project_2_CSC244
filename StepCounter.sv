/*
Module name: upcount2
Description: counter to determine timestep
By: Norman Nguyen
Created: 11/17/2023
Updated:

In: 
	CLR = reset signal
	CLKb = clock signal

Out:
	[1:0] CNT = current timestep signals - 2 bits

Quick copy:
upcount2(.CNT() , .CLR(), .CLKb());
*/

module upcount2(

	input logic CLR, CLKb,
	output logic [1:0] CNT
);

//MAXIMUM STEP WITH 2 BITS = 4 values range from 0 to 3

	always_ff@(negedge(CLKb))
	begin
		if(CLR)
			CNT <= 0;
		else
			CNT <= CNT + 1;
	end



endmodule