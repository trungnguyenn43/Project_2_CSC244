/*
Module name: outputlogic
Description: output logic for the project
By: 
Created: 11/17/2023
Updated:

In: 
	[9:0] BUS = Data bus signal 
	[9:0] REG = Register output signal (Q1)
	TIME = timestep signal
	DONE = DONE operation signal (dot on HEX5)
	PEEKb = Peek signal (show the current number on data bus to 3 7seg display)

Out:
	[9:0] LED_B = out LEDs light signal, show current value on the data bus
	[6:0] DHEX [2:0] = three 7seg display output 
	[6:0] THEX = timestep to HEX5 7seg display
	LED_D = dot on HEX5 to show that the operation is done
	
Quick copy:
upcount2(.CNT() , .CLR(), .CLKb());
*/

module OutputLogic(
	
	input logic [9:0] BUS, REG,
	input logic TIME,
	input logic PEEKb,
	input logic DONE,
	
	output logic [9:0] LED_B,
	output logic [6:0] DHEX [2:0], THEX,
	output logic LED_D
	
);

	
	
	
	



endmodule