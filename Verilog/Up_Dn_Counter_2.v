module Up_Dn_Counter_2	(
	input	wire [4:0] IN,
	input	wire load, down, up,
	input	wire CLK,
	output	wire high, low,
	output	reg  [4:0] counter
	);
	
reg [4:0] temp;

always@(posedge CLK)
begin
counter <= temp;
end

always@(*)
begin
	if(load)
	begin
		temp = IN;
	end
	
	else if(down && !low)
	begin
		temp = counter - 5'b1;
	end
	
	else if(up && !high && !down) //to prevent flickering when both up and down are high and down reaches zero
	begin
		temp = counter + 5'b1;
	end
	
	else
	begin
		temp = counter;
	end
end

assign low  = (counter == 5'b00000);

assign high = (counter == 5'b11111);

endmodule