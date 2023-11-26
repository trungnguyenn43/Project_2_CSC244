module controller(
	input logic [9:0] INSTR,
	input logic [1:0] T,
	output logic [5:0] IMM,
	output logic [1:0] Rin, Rout,
	output logic ENW, ENR, Ain, Gin, Gout, 
	output logic [3:0] ALUcont,
	output logic Ext, IRin, Clr
);

	/*
	* create a sequential controller
	* 	need a counter to keep track of current step (sequential logic!) - always_ff
	*	need a combinational logic circuit to assign outputs based on current step - always_comb
	*/
	
	
	logic [1:0] sigBits;
	assign sigBits= INSTR[9:8];
	logic [3:0] opINSTR;
	assign opINSTR= INSTR[3:0];
	logic [1:0] rx, ry;
	assign rx = INSTR[7:6];
	assign ry = INSTR[5:4];
	logic isLoad, isCopy, isOP1, isOP2, isOP3;
	
	
	
	always_comb
		case(T)
		//timesteps 1-4
			//1ST TS
			2'b00: begin
				IRin = 1;
				Ext = 1;
				Clr = 0;
				ENW = 0;
				ENR = 0;
				Ain = 0;
				Gin = 0;
				Gout = 0;
			end
			//2ND TS
			2'b01: begin
				IRin = 0;
					
				case(INSTR)
					//LOAD
					10'b00????0000: begin					
						//Ext= 1;
						ENW= 1;
						Clr= 1;
					end
					//COPY
					10'b00????0001: begin
						Ext= 0;
						ENW= 1;
						ENR= 1;
						Clr= 1;
					end
					//INV & FLP
					10'b00????0100, 10'b00????0101: begin
						Rout= ry;
						Ext= 0;
						ENR= 1;
						Gin= 1;
						ALUcont = opINSTR; //assign val for FN 
					end
					//ADD/SUB IMM
					10'b10????????, 10'b11????????: begin					
						IMM= INSTR[5:0];
						Ain= 1;
					end
					default: begin
						Rout= ry;
						Ext= 0;
						ENR= 1;
						Ain= 1;
						ALUcont = opINSTR; //assign val for FN
					end
					
				endcase
					
			end
			//3RD TS
			2'b10: begin
				case(INSTR)
					
					//LOAD & COPY SHOULD NEVER GET 
					//TO THE 3RD OR 4TH CLOCK PULSE
					
					//INV & FLP
					10'b00????0100, 10'b00????0101: begin
						Rin= rx;
						ENR= 0;
						Gin= 0;
						Gout= 1;
						ENW= 1;
						Clr= 1;
						ALUcont = opINSTR; //assign val for FN
					end
					//ADD/SUB IMM
					10'b10????????, 10'b11????????: begin
						//IMM= INSTR[5:0];
						Ain= 0;
						Gin= 1;
						ENR= 1;
						Rout= rx;
						
					end
					default: begin
						Rout= rx;
						ENR= 1;
						Ain= 0;
						Gin= 1;
						ALUcont = opINSTR; //assign val for FN
					end
				endcase
				
			end
			//4TH TS
			2'b11: begin
				
				//INV & FLP SHOULD NEVER GET 
				//TO THE 4TH CLOCK PULSE
				
				case(INSTR) 
					//ADD/SUB IMM
					10'b10????????, 10'b11????????: begin
						//IMM= INSTR[5:0];
						Gin= 0;
						ENR= 1;
						Gout= 1;
						ENW= 1;
						Rin= rx;
						Clr= 1;
						
					end
					default: begin
						Rin= rx;
						ENR= 0;
						Gin= 0;
						Gout= 1;
						ENW= 1;
						Clr= 1;
						ALUcont = opINSTR; //assign val for FN
					end
				endcase
				
			end
			default: begin
			//this is stupid
			end
			
		endcase
			
	
	

endmodule 