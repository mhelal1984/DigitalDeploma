module arith_module #(
parameter in_width 	= 16,
parameter out_width	= 16
)
(
input	wire	[in_width-1:0]	A,B,			//done
input	wire	[1:0]			OP,				//done
input	wire					CLK,RST,		//done
input	wire					enable,			//done
output	reg		[out_width-1:0]	arith_out,		//done
output	reg						carry_out,		//done
output	reg						arith_flag		//done
);

reg	[out_width-1:0]	arith_out_comp; 	//combinational cloud signal for arith_out  register
reg					carry_out_comp; 	//combinational cloud signal for carry_out  register
reg					arith_flag_comp;	//combinational cloud signal for arith_flag register

always@(negedge RST or posedge CLK)
//always block for registers only and resets registers only
//to avoide simulator race		
begin
	if(!RST)
	begin
		arith_flag <= 1'b0;
		carry_out  <= 1'b0;
		arith_out  <= 0;
	end
	
	else
	begin
		carry_out  <= carry_out_comp;
		arith_out  <= arith_out_comp;
		arith_flag <= arith_flag_comp;
	end
end

	

always@(*)
begin
	if(enable)	//enable compinational cloud signal
	begin
		arith_flag_comp = 1'b1;
		case(OP)
			2'b00:	begin
					{carry_out_comp,arith_out_comp} = A+B;	//addition
					end	
			2'b01:	begin	
					{carry_out_comp,arith_out_comp} = A-B;	//subtraction
					end	
			2'b10:	begin	
					{carry_out_comp,arith_out_comp} = A*B;	//multiplication
					end	
			2'b11:	begin	
					{carry_out_comp,arith_out_comp} = A/B;	//division
					end		
		endcase
	end
	
	else	//if not enabled , combinational cloud output is zero
	begin
		arith_flag_comp = 0;
		arith_out_comp  = 0;
		carry_out_comp  = 0;
	end
end

endmodule