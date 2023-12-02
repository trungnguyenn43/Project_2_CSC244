/*
Module name: outputlogic
Description: output logic for the project
By: Leo and Norman
Created: 11/17/2023
Updated: 11/27/2023

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
OutputLogic(.LED_B() , .DHEX(), .THEX(), .LED_D(), .BUS(), .REG(), .TIME(), .PEEKb(), .DONE());
*/

module OutputLogic(
	
	input logic [9:0] BUS, REG,
	input logic [1:0] TIME,
	input logic PEEKb,
	input logic DONE,
	
	output logic [9:0] LED_B,
	output logic [6:0] DHEX0, DHEX1, DHEX2,
	output logic [7:0] THEX
);

	logic [9:0] outLogic;
	
	assign LED_B= BUS;
	
	always_comb
	begin
		if(PEEKb)
		begin
			outLogic= BUS;
		end
		else
		begin
			outLogic= REG;
		end
	end
	
	seven_seg digit0(.s(DHEX0) , .a(outLogic[3:0]));
	seven_seg digit1(.s(DHEX1) , .a(outLogic[7:4]));
	seven_seg digit2(.s(DHEX2) , .a({2'b00, outLogic[9:8]}));
	seven_seg Timestep(.s(THEX[6:0]) , .a({2'b00, TIME}));
	
	assign THEX [7] = ~DONE;

endmodule
