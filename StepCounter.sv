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





endmodule