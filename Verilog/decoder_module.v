module decoder_module (
input	wire	[1:0]	in_dec,
output	reg				Arith_Enable,
output	reg				Logic_Enable,
output	reg				CMP_Enable,
output	reg				Shift_Enable
);

always@(*)
begin
Arith_Enable	=	1'b0;
Logic_Enable	=	1'b0;
CMP_Enable		=	1'b0;
Shift_Enable	=	1'b0;

	case (in_dec) //decoder 2 bit input
		2'b00:begin
				Arith_Enable = 1'b1;
			  end
		2'b01:begin
				Logic_Enable = 1'b1;
			  end
		2'b10:begin
				CMP_Enable 	 = 1'b1;
			  end
		2'b11:begin
				Shift_Enable = 1'b1;
			  end
	 endcase
end
endmodule