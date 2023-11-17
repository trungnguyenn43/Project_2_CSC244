/*
Module name: seven_seg
Description: get a number input and show the correct number on seven segment display
By: Norman Nguyen
Date: 11/17/2023

In: 
	a = number input bits

Out:
	out_sig = signals out to 7seg display
	out_enable = out signal for the dot on 7seg display

Quick copy:
seven_seg(.out_sig() , .a());
*/

module seven_seg(
	input logic [3:0] a,
	output logic [6:0] out_sig, output logic out_enable);
	
	logic [15:0] y;
	
	logic in_enable;
	assign in_enable = 1'b1;
	
	//Decoder -> change output combinations to cases
	assign	y[0] = (~a[3] * ~a[2] * ~a[1] * ~a[0]) * in_enable;
	assign	y[1] = (~a[3] * ~a[2] * ~a[1] * a[0]) * in_enable;
	assign	y[2] = (~a[3] * ~a[2] * a[1] * ~a[0]) * in_enable;
	assign	y[3] = (~a[3] * ~a[2] * a[1] * a[0]) * in_enable;
	assign	y[4] = (~a[3] * a[2] * ~a[1] * ~a[0]) * in_enable;
	assign	y[5] = (~a[3] * a[2] * ~a[1] * a[0]) * in_enable;
	assign	y[6] = (~a[3] * a[2] * a[1] * ~a[0]) * in_enable;
	assign	y[7] = (~a[3] * a[2] * a[1] * a[0]) * in_enable; //7
	assign	y[8] = (a[3] * ~a[2] * ~a[1] * ~a[0]) * in_enable; //-8
	assign	y[9] = (a[3] * ~a[2] * ~a[1] * a[0]) * in_enable;	//-7
	assign	y[10] = (a[3] * ~a[2] * a[1] * ~a[0]) * in_enable;	//-6
	assign	y[11] = (a[3] * ~a[2] * a[1] * a[0]) * in_enable;	//-5
	assign	y[12] = (a[3] * a[2] * ~a[1] * ~a[0]) * in_enable;	//-4
	assign	y[13] = (a[3] * a[2] * ~a[1] * a[0]) * in_enable;	//-4
	assign	y[14] = (a[3] * a[2] * a[1] * ~a[0]) * in_enable;	//-2
	assign	y[15] = (a[3] * a[2] * a[1] * a[0]) * in_enable;	//-1
	
	assign	out_sig[0] = ~(y[0] | y[2] | y[3] | y[5] | y[6] | y[7] | y[8] | y[9] | y[10] | y[12] | y[14] | y[15]);
	assign	out_sig[1] = ~(y[0] | y[1] | y[2] | y[3] | y[4] | y[7] | y[8] | y[9] | y[10] | y[13]);
	assign	out_sig[2] = ~(y[0] | y[1] | y[3] | y[4] | y[5] | y[6] | y[7] | y[8] | y[9] | y[10] | y[11] | y[13]);
	assign	out_sig[3] = ~(y[0] | y[2] | y[3] | y[5] | y[6] | y[8] | y[9] | y[11] | y[12] | y[13] | y[14]);
	assign	out_sig[4] = ~(y[0] | y[2] | y[6] | y[8] | y[10] | y[11] | y[12] | y[13] | y[14] | y[15]);
	assign	out_sig[5] = ~(y[0] | y[4] | y[5] | y[6] | y[8] | y[9] | y[10] | y[11] | y[12] | y[14] | y[15]);
	assign	out_sig[6] = ~(y[2] | y[3] | y[4] | y[5] | y[6] | y[8] | y[9] | y[10] | y[11] | y[13] | y[14] | y[15]);
	
	
endmodule 