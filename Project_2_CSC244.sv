/*
Module: Top level module for project 2
Created 11/17/2023
Last updated: 

INSTRUCTION FOR PIN ASSIGN

Inputs:
	[9:0] IN_DATA_BUS = SWITCH[9:0]
	CLKb = KEY0
	CLK50MHz = on-board 50MHz clock = Pin_P11
	PKb = KEY1

Outputs:
	OUT_DATA_BUS = LEDR[9:0]
	DHEX [2:0] = HEX2:0 //ignore DHEX[0], DHEX[1], and DHEX[2] in pin assign table
	THEX = HEX5
	Done = the dot on HEX5 = PIN_L19
	
	
	
*/


module Project_2_CSC244(
	
	input logic [9:0] IN_DATA_BUS,
	input logic CLK, CLK50MHz, PKb,
	
	output logic [9:0] OUT_DATA_BUS,
	output logic [6:0] DHEX [2:0], //this is an array, like this DHEX[0][0]
	output logic [6:0] THEX,
	output logic Done

);
	
	//Data bus
	logic [9:0] BUS;
	
	/*Debouncer quick copy:
		debouncer (.A(), .A_noisy(), .CLK50M());
	*/
	logic CLKDb; //CLK after debounced
	debouncer CLKDebouncer(.A(CLKDb), .A_noisy(CLK), .CLK50M(CLK50MHz))

	logic PKdb; //PKdb -> peek
	debouncer PKDebouncer(.A(PKdb), .A_noisy(PKb), .CLK50M(CLK50MHz));

	
	

endmodule