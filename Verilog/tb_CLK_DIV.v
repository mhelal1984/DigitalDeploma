`timescale 1ns/1ps

module tb_CLK_DIV();
reg				CLK,
				i_rst_n,
				i_clk_en;
reg    [4:0]	i_div_ratio;
reg				RST;
wire			o_div_clk;

reg [16:0]		counter;

CLK_DIV DUT(
CLK, 
i_rst_n, 
i_clk_en, 
i_div_ratio, 
o_div_clk
);


//mock counter that counts positive edges of output clock
//to make sure the number of edges matches with different frequencies

//example : let ref_clk be of periode 1ns 
//for 300ns time of f/2 we should have 150 positive edges
//for 300ns time of f/3 we should have 100 positive edges
//for 300ns	time of f/4 we should have 75  positive edges
//for 300ns	time of f/5 we should have 60  positive edges
always@(posedge o_div_clk,negedge RST)
begin
if (!RST) 	counter<= 0;
else		counter<=counter+1;
end


initial
begin
	$dumpfile("tb_CLK_DIV.vcd");
	$dumpvars;
	counter = 0;
	CLK 		= 0;
	i_clk_en	= 1;
	i_div_ratio	= 5'd2;
	i_rst_n		= 1;
	RST			= 1;
	#300
	
	//check if 150
	if (counter == 'd150)		$display ("divider successful for f/2 case")       ;
	else						$display ("divider is NOT successful for f/2 case");
	i_div_ratio	= 5'd3;
	#0.001 RST = 0;
	#0.001 RST = 1;
	
	#300
	//check if 100
	if (counter == 'd100)		$display ("divider successful for f/3 case")       ;
	else						$display ("divider is NOT successful for f/3 case");
	i_div_ratio	= 5'd4;
	#0.001 RST = 0;
	#0.001 RST = 1;

	#300
	//check if 75
	if (counter == 'd75)		$display ("divider successful for f/4 case")       ;
	else						$display ("divider is NOT successful for f/4 case");
	i_div_ratio	= 5'd5;
	#0.001 RST = 0;
	#0.001 RST = 1;
	
	#300
	//check if 60
	if (counter == 'd60)		$display ("divider successful for f/5 case")       ;
	else						$display ("divider is NOT successful for f/5 case");
	#0.001 RST = 0;
	#0.001 RST = 1;
	i_clk_en = 0;
	
	#300
	//check enable pin
	if (counter == 300)			$display("divider successful for enable pin")		;
	else						$display("divider is NOT successful for enable pin");
	
	#50
	$stop;
	
end

always #0.5 CLK = ~CLK;

endmodule
