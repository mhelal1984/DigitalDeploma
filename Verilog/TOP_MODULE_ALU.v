module TOP_MODULE_ALU #(
parameter in_width		= 16,
parameter out_width		= 16,
parameter CMP_out_width = 2
)
(
input	wire	[in_width-1:0]	         A,B,
input	wire	[3:0]                    ALU_FUN,
input	wire	                         CLK,RST,
output	wire	[out_width-1:0]          arith_out,logic_out,shift_out,    
output	wire	[CMP_out_width-1:0]		 CMP_out,
output	wire	                       	 arith_flag,logic_flag,CMP_flag,shift_flag,
output	wire							 carry_out
);

wire				Arith_Enable,Logic_Enable,CMP_Enable,Shift_Enable;

decoder_module 		
u1(
//input
.in_dec       (ALU_FUN[3:2]),	//Decoder interface mapping

//outputs
.Arith_Enable (Arith_Enable),	//Decoder interface mapping
.Logic_Enable (Logic_Enable),	//Decoder interface mapping
.CMP_Enable   (CMP_Enable)  ,	//Decoder interface mapping
.Shift_Enable (Shift_Enable)	//Decoder interface mapping
);

arith_module #(.in_width(in_width),.out_width(out_width))
u2(
//inputs
.A	    	 (A),
.B      	 (B),
.OP     	 (ALU_FUN[1:0]),
.CLK    	 (CLK),
.RST    	 (RST),
.enable 	 (Arith_Enable),

//outputs
.arith_out   (arith_out),
.carry_out   (carry_out),
.arith_flag  (arith_flag)
);

logic_module #(.in_width(in_width),.out_width(out_width))
u3(
//inputs
.A	    	 (A),
.B      	 (B),
.OP     	 (ALU_FUN[1:0]),
.CLK    	 (CLK),
.RST    	 (RST),
.enable 	 (Logic_Enable),

//outputs
.logic_out   (logic_out),
.logic_flag  (logic_flag)
);

CMP_module #(.in_width(in_width),.out_width(CMP_out_width))
u4(
//inputs
.A	    	 (A),
.B      	 (B),
.OP     	 (ALU_FUN[1:0]),
.CLK    	 (CLK),
.RST    	 (RST),
.enable 	 (CMP_Enable),

//outputs
.CMP_out   (CMP_out),
.CMP_flag  (CMP_flag)
);

shift_module #(.in_width(in_width),.out_width(out_width))
u5(
//inputs
.A	    	 (A),
.B      	 (B),
.OP     	 (ALU_FUN[1:0]),
.CLK    	 (CLK),
.RST    	 (RST),
.enable 	 (Shift_Enable),

//outputs
.shift_out   (shift_out),
.shift_flag  (shift_flag)
);

endmodule