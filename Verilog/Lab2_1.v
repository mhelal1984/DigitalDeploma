module lab2_1	(
	input wire [3:0] IN,
	input wire latch,
	input wire dec,
	input wire clk,
	output wire	zero_flag
	);
	
reg [3:0] counter;

always@(posedge clk)
begin
	if (latch)
	begin
		counter <= IN;
	end
	
	else if (dec&&!zero_flag)
	begin
		counter <= counter - 4'b1;
	end
	
	//else					  //****Not Used :doesn't change anything****//
	//begin					  //****Not Used :doesn't change anything****//
	//	counter <= counter;   //****Not Used :doesn't change anything****//
	//end					  //****Not Used :doesn't change anything****//
end

assign zero_flag = (counter == 4'b0);

endmodule