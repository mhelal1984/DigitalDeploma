module CMP_module #(
parameter in_width  = 16,
parameter out_width = 2		//default output is two bits
)
(
input	wire	[in_width-1:0]	A,B,		
input	wire	[1:0]			OP,			
input	wire					CLK,RST,	
input	wire					enable,		
output	reg		[out_width-1:0]	CMP_out,	
output	reg						CMP_flag	
);

reg		[out_width-1:0]			CMP_out_comp;	//combinational cloud output
reg								CMP_flag_comp;	//combinational cloud output

always@(negedge RST or posedge CLK)
//always block for registers only to avoide
//simulator race
begin
	if(!RST)
	begin
		CMP_flag <= 1'b0;
		CMP_out	 <= 0;
	end
	
	else
	begin
		CMP_out 	<= CMP_out_comp;
		CMP_flag	<= CMP_flag_comp;
	end
end

always@(*)
begin
	if(enable)
	begin
		CMP_flag_comp = 1'b1;
		case(OP)
			2'b00:	begin
					CMP_out_comp = 0;				  // NO Operation
					end	
			2'b01:	begin
					CMP_out_comp = (A==B)?2'b01:2'b0; // Equality
					end	 
			2'b10:	begin
					CMP_out_comp = (A>B)? 2'b10:2'b0; // A larger than B
					end	 
			2'b11:	begin
					CMP_out_comp = (A<B)? 2'b11:2'b0; // A smaller than B
					end		
		endcase
	end
	
	else
	begin
		CMP_flag_comp = 1'b0;
		CMP_out_comp  = 0;
	end
end



endmodule