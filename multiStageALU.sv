module ALU#(
	parameter N = 10
)
(
  input logic [N-1:0] OP ,
  input logic [3:0] FN ,
  input logic Ain , Gin , Gout , CLKb ,
  output logic [N-1:0] Q
);
	
	parameter ADD = 4'b0010;
	parameter SUB = 4'b0011;
	parameter AND = 4'b0110;
	parameter OR = 4'b0111;
	parameter XOR = 4'b1000;
  // do the rest of parameters (should be ~12)
  
  logic [N-1:0] addSubResult;
	"addsub module goes here" sum(.A(A), .B(B), .C(ALUControl[0]), .S(addSubResult));
	
	
	
	always_comb begin
		//ALU cases mux
		case(FN)
			ADD: Q = addSubResult;
			SUB: Q = addSubResult;
			AND: Q = A & B; //andOrResult;
			OR: Q = A | B;
      XOR: Q =
		endcase
	end
	
	
	
endmodule 
