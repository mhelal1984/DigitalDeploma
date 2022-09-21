module BIT_SYNC #(
parameter num_stages = 3, 
parameter bus_width	 = 1
)
(
input 	wire						RST, CLK_destination,
input	wire 	[bus_width-1:0]		async,
output	reg		[bus_width-1:0]		sync
);

//shift register architecture of synchronizer
reg	[num_stages-1:0] shift_reg;


always@(posedge CLK_destination,negedge RST)
begin
	if(!RST)
	begin
		shift_reg <= 'b0;
	end
	
	else
	begin
		
		{sync,shift_reg[num_stages-1:0]} <= {shift_reg[num_stages-1 : 0],async};
	end
	
end


endmodule