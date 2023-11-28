/*
Module: Top level module for project 2
Created 11/17/2023
Last updated: 11/27/2023

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
	output logic [6:0] DHEX0, DHEX1, DHEX2,
	output logic [7:0] THEX

);

	//internal wires
	logic [9:0] BUS, INSTR, REG;
	logic [1:0] TIME;
	logic Ext, IRin, Clr, ENW, ENR, Ain, Gin, Gout;
	logic [1:0] WRA, RDA0, RDA1;
	logic [3:0] ALUcont;
	
	
	
	logic CLKDb; //CLK after debounced
	debouncer CLKDebouncer(.A(CLKDb), .A_noisy(CLK), .CLK50M(CLK50MHz));

	logic PKdb; //PKdb -> peek
	debouncer PKDebouncer(.A(PKdb), .A_noisy(PKb), .CLK50M(CLK50MHz));
	
	//tri-state buffer
	tBuffer buffboi(.Q(BUS), .E(Ext), .D(IN_DATA_BUS));
	
	//instr register
	instructionReg instr(.Q(INSTR), .EN(IRin), .CLKb(CLKDb), .D(BUS));
	
	//counter
	upcount2 count(.CNT(TIME), .CLR(Clr), .CLKb(CLKDb));
	
	//controller
	controller cont(.IMM(BUS), .Rin(WRA), .Rout(RDA0), .ENW(ENW), .ENR(ENR0), .Ain(Ain), .Gin(Gin), .Gout(Gout), .ALUcont(ALUcont), .Ext(Ext), .IRin(IRin), .Clr(Clr), .INSTR(INSTR), .T(TIME));
	
	//register file
	registerFile reggie(.Q0(BUS), .Q1(REG), .D(BUS), .WRA(WRA), .ENW(ENW), .RDA(RDA0), .ENR0(ENR0), .RDA1(IN_DATA_BUS[1:0]), ENR1(1'b1), .CLKb(CLKDb));
	
	//alu
	MultiStageALU alulululu(.RES(BUS), .OP(BUS), .Ain(Ain), .Gin(Gin), .Gout(Gout), .FN(ALUcont));
	
	//output
	OutputLogic(.LED_B(OUT_DATA_BUS), .DHEX0(DHEX0), .DHEX1(DHEX1), .DHEX2(DHEX2), .THEX(THEX), .BUS(BUS), .REG(Q1), .TIME(TIME), .PEEKb(PKdb), .DONE(Clr));


endmodule
