module 16bit_ALU(
	input	wire	[15:0]	A,B,
	input	wire	[3:0]	ALU_FUN,
	input	wire			clk,
	output	reg		[15:0]	ALU_OUT,
	output	wire			Arith_flag, Logic_flag, CMP_flag, Shift_flag
);

always@(*)
begin
	case(ALU_FUN)
		4'b0000	:	
		4'b0001	:	
		4'b0010	:	
		4'b0011	:	
		4'b0100	:	
		4'b0101	:	
		4'b0110	:	
		4'b0111	:	
		4'b1000	:	
		4'b1001	:	
		4'b1010	:	
		4'b1011	:	
		4'b1100	:	
		4'b1101	:	
		4'b1110	:	
		default	:	
	endcase
end