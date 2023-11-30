module controller(
	input logic [9:0] INSTR,
	input logic [1:0] T,
	output logic [9:0] IMM,
	output logic [1:0] Rin, Rout,
	output logic ENW, ENR, Ain, Gin, Gout, 
	output logic [3:0] ALUcont,
	output logic Ext, IRin, Clr
);

	logic [3:0] FN;
	assign FN= INSTR[3:0];
	logic [1:0] rx, ry;
	assign rx = INSTR[7:6];
	assign ry = INSTR[5:4];
	logic [5:0] IMMV;
	assign IMMV= INSTR[5:0];
	parameter
		LOAD = 4'b0000,
		COPY = 4'b0001,
		ADD = 4'b0010,
		SUB = 4'b0011, 
		INV = 4'b0100,
		FLP = 4'b0101, 
		AND = 4'b0110, 
		OR = 4'b0111,
		XOR = 4'b1000,
		LSL = 4'b1001,
		LSR = 4'b1010,
		ASR = 4'b1011;
		
	always_comb begin
	
	//DEFAULT VALUES FOR CONTROLLER
	Rin= 2'b00; Rout= 2'b00; ALUcont= 4'b0000; ENW= 1'b0; ENR= 1'b0; IRin= 1'b0; Ext= 1'b0; 
	Ain= 1'b0; Gin= 1'b0; Gout= 1'b0; Clr= 1'b0; IMM= 10'bz;
	
		case(T)
		//timesteps 1-4
			//1ST TS
			2'b00: begin
				IRin = 1; Ext = 1;
			end
			//2ND TS
			2'b01: begin
				if(INSTR[9]) begin
					ENR= 1;
					Ain= 1;
					Rout= rx;
				end
				else begin
					case(FN)
						LOAD: 
						begin					
							Ext= 1; Rin= rx; ENW= 1; Clr= 1;
						end
						COPY: 
						begin
							Rout= ry; Rin= rx; ENW= 1;	ENR= 1; Clr= 1;
						end
						INV, FLP: 
						begin
							Rout= ry; ENR= 1; Gin= 1;
							if(INV)
								ALUcont= INV;
							else
								ALUcont= FLP;
						end
						ADD, SUB, AND, OR, XOR, LSL, LSR, ASR: 
						begin
							Rout= rx; ENR= 1; Ain= 1; 
						end
					endcase
				end
			end
			//3RD TS
			//LOAD & COPY NEVER GET HERE
			2'b10: begin
				if(INSTR[9]) begin
					Gin= 1;
					IMM= {4'b0, IMMV};
					if(INSTR[8])
						ALUcont= SUB;
					else
						ALUcont= ADD;
				end
				else begin
					case(FN)
						ADD:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= ADD;
						end
						SUB:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= SUB;
						end
						AND:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= AND;
						end
						OR:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= OR;
						end
						XOR:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= XOR;
						end
						LSL:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= LSL;
						end
						LSR:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= LSR;
						end
						ASR:
						begin
							Rout= ry; ENR= 1; Gin= 1;
							ALUcont= ASR;
						end
						INV, FLP:
						begin
							Rin= rx; ENW= 1; Gout= 1; Clr= 1;
						end
					endcase
				end
			end
			//4TH TS
			//FLP & INV NEVER GET HERE
			2'b11: begin
				Gout= 1;
				Rin= rx;
				ENW= 1;
				Clr= 1;
			end
		endcase
	end
endmodule 

