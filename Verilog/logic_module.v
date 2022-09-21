module logic_module #(
parameter in_width 	= 16,
parameter out_width	= 16
)
(
input	wire	[in_width-1:0]	A,B,		//done
input	wire	[1:0]			OP,			//done
input	wire					CLK,RST,	//done
input	wire					enable,		//done
output	reg		[out_width-1:0]	logic_out,	//done
output	reg						logic_flag	//done
);

reg		[out_width-1:0]		logic_out_comp; 		//combinational cloud output
reg							logic_flag_comp;		//combinational cloud output

always@(negedge RST or posedge CLK)
//always block for registers only to avoide
//simulator race
begin
	if(!RST)
	begin
		logic_flag <= 1'b0;
		logic_out  <= 0;
	end
	
	else
	begin
		logic_flag <= logic_flag_comp;
		logic_out  <= logic_out_comp;
	end
end

always@(*)
begin
	if(enable)	//enable compinational cloud signal
	begin
		logic_flag_comp = 1'b1;
		case(OP)
			//AND
			4'b00	:	begin
							logic_out_comp = A&B;
						end
			//OR
			4'b01	:	begin
							logic_out_comp = A|B;
						end
			//NAND
			4'b10	:	begin
							logic_out_comp = ~(A&B);
						end
			//NOR
			4'b11	:	begin
							logic_out_comp = ~(A|B);
						end
			endcase
	end
	
	else		//if not enabled , combinational cloud output is zero
	begin
		logic_out_comp = 0;
		logic_flag_comp	   = 1'b0;
	end
end




endmodule