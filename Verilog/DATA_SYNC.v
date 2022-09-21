module DATA_SYNC #(parameter NUM_STAGES = 4,parameter bus_width = 8)
(
input		wire	[bus_width-1:0]		ASYNC,
input		wire						CLK,RST,
input		wire						bus_enable,
output		reg		[bus_width-1:0]		SYNC,
output		reg						enable_pulse
);

//shift register for the synchronizer
reg		[NUM_STAGES-1:0]		shift_reg;
reg								Q_last;
wire							pulse_gen_out;
wire	[bus_width-1: 0]		mux_out;



//shift register block ////////////////////////////////////////////////////		
always@(posedge CLK,negedge RST)
begin
	if(!RST)
	begin
		shift_reg <= 0;
	end
	
	else
	begin
		shift_reg[NUM_STAGES-1:0] <= {bus_enable,shift_reg[NUM_STAGES-1:1]};// 1=>2, 2=>3, . . . 
	end
end


//pulse gen /////////////////////////////////////////////////////////////		
always@(posedge CLK,negedge RST)
begin
	if(!RST)
	begin
		Q_last <= 0;
	end
	
	else
	begin
		Q_last <= shift_reg[0];
	end
end
assign pulse_gen_out = shift_reg[0]&!Q_last;


//enable_pulse register ////////////////////////////////////////////////		
always@(posedge CLK, negedge RST)
begin
	if(!RST)
	begin
		enable_pulse <= 0;
	end
	
	else
	begin
		enable_pulse <= pulse_gen_out;
	end
end


//enable_pulse register ////////////////////////////////////////////////		
assign mux_out = (pulse_gen_out)? ASYNC:SYNC;
always@(posedge CLK, negedge RST)
begin
	if(!RST)
	begin
		SYNC <= 0;
	end
	
	else
	begin
		SYNC <= mux_out;
	end
end


endmodule