module tBuffer(
	input logic [9:0] D,
	input logic E,
	output logic [9:0] Q
);

	always_comb
	begin
		if(E)
			Q= D;
		else
			Q= 10'bz;
	end


endmodule