module lab2_2	(
	input wire latch,dec,
	input wire clk,
	input wire [3:0] IN,
	output wire zero_flag
	);

reg [3:0] temp, counter;

always@(*)
begin
	if(latch)
	begin
		temp = IN;
	end
	
	else if(dec && !zero_flag)
	begin
		temp = counter - 1;
	end
	
	else
	begin
		temp = counter;
	end
end

always@(posedge clk)
begin
	counter <= temp;
end

assign zero_flag = (counter == 4'b0);

endmodule