module CLK_DIV (
input		wire			i_ref_clk,
input		wire			i_rst_n,
input		wire			i_clk_en,
input		wire	[4:0]	i_div_ratio,
output		reg				o_div_clk
);


reg [4:0]	counter,n;


//ability to reset or register "i_div_ratio"
always@(posedge i_ref_clk, negedge i_rst_n)
begin
	if(!i_rst_n)
	n <= 0;
	else
	n <= i_div_ratio; 
end

//counter that counts "i_div_ratio" times and resets
always@(posedge i_ref_clk, negedge i_rst_n)
begin
	if(!i_rst_n)
	begin
		counter <= 0;
	end
	
	else if(counter < n-1)
	begin
		counter <= counter + 1;
	end
	
	else
	begin
		counter <= 0;
	end
end

//assig "o_div_clk" to 1 half of the time in case of 
//even integer and (half-1) in case of odd integer
//and the rest is zero 
always@(*)
begin
	if (i_clk_en & (n!=0|n!=1))
	begin
		o_div_clk = (counter < n >> 1) ? 1'b1:1'b0;
	end
	
	else
	begin
		o_div_clk = i_ref_clk;
	end
end

endmodule
