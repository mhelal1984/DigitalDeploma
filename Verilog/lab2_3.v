module lab2_3(
	input wire [3:0] IN,
	input wire dec,latch,
	input wire clk,
	output reg zero_flag
	);
	
reg [3:0] counter, temp;

always@(*)
begin
	if(latch)
	begin
		temp = IN;
	end
	
	else if(dec&& !zero_flag)
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
	counter<= temp;
end

always@(*)
begin
	if(counter == 4'b0)
	begin
		zero_flag = 1'b1;
	end
	
	else
	begin
		zero_flag = 1'b0;
	end
end

endmodule