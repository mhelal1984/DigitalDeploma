module Up_Dn_Counter	(
	input 	wire [4:0] IN,
	input 	wire load, up, down,
	input 	wire clk,
	output 	wire h_flag, l_flag,
	output 	reg [4:0] counter
	);


always@(posedge clk)
begin
	if(load)
	begin
		counter <= IN;
	end
	
	else if(down && !l_flag)
	begin
		counter <= counter - 5'b1;
	end
	
	else if(up && !h_flag)
	begin
		counter <= counter + 5'b1;
	end
end

assign l_flag = (counter == 5'b00000);
assign h_flag = (counter == 5'b11111);

endmodule