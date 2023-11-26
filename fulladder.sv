
module fulladder(
		input logic A,B, Ci,
		output logic S, Co
);

always_comb
	begin
		if(Ci)
			begin
				Co <= A | B;
				S <= A ~^ B;
			end
		else
			begin
				Co <= A & B;
				S <= A ^ B;
			end
	end

endmodule