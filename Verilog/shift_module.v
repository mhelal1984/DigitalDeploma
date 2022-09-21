module shift_module #(
parameter in_width  = 16,
parameter out_width = 16
)
(
input	wire	[in_width-1:0]	A,B,		
input	wire	[1:0]			OP,			
input	wire					CLK,RST,	
input	wire					enable,		
output	reg		[out_width-1:0]	shift_out,	
output	reg						shift_flag	
);

reg		[out_width-1:0]			shift_out_comp;	    //combinational cloud output
reg								shift_flag_comp;	//combinational cloud output

always@(negedge RST or posedge CLK)
//always block for registers only to avoide
//simulator race
begin
	if(!RST)
	begin
		shift_flag <= 1'b0;
		shift_out	 <= 0;
	end
	
	else
	begin
		shift_out 	<= shift_out_comp;
		shift_flag	<= shift_flag_comp;
	end
end

always@(*)
begin
	if(enable)
	begin
		shift_flag_comp = 1'b1;
		case(OP)
			2'b00:	begin
					shift_out_comp = A>>1'b1;			// shift A right
					end	
			2'b01:	begin
					shift_out_comp = A<<1'b1;			// shift A left
					end	 
			2'b10:	begin
					shift_out_comp = B>>1'b1;			// shift B right
					end	 
			2'b11:	begin
					shift_out_comp = B<<1'b1;			// shift B left
					end		
		endcase
	end
	
	else
	begin
		shift_flag_comp = 1'b0;
		shift_out_comp  = 0;
	end
end



endmodule