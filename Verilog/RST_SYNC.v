module RST_SYNC #(parameter NUM_STAGES = 4)
(
input		wire		CLK,RST,
output		wire		SYNC_RST
);


//shift register for the synchronizer
reg		[NUM_STAGES-1:0]		shift_reg;


//shift register block ////////////////////////////////////////////////////		
always@(posedge CLK,negedge RST)
begin
	if(!RST)
	begin
		shift_reg <= 0;
	end
	
	else
	begin
		shift_reg[NUM_STAGES-1:0] <= {1'b1,shift_reg[NUM_STAGES-1:1]};// 1'b1=last, last=>last-1, . . . , 1=>0
	end
end

//output //////////////////////////////////////////////////////////////////
assign SYNC_RST = shift_reg[0];

endmodule
