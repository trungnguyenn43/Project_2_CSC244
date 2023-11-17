module instructionReg#(
	parameter N = 10 //variable width register
)
(input logic [N-1:0] D, E, CLKb,
output logic [N-1:0] Q);

	always_ff@(negedge CLKb)
	begin 
		if(E)
			Q <= D;
		else
			Q <= Q;
	end
endmodule