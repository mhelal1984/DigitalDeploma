`timescale 1ns/10ps

module tb_DATA_SYNC #(parameter num_stages = 3, 
parameter bus_width	 = 4)();

//interface ports//	/////////////	////////////	////////////	////////////
reg								RST, CLK_destination, CLK_source,bus_enable;
wire		[bus_width-1:0]		async;
wire		[bus_width-1:0]		sync;
wire							enable_pulse;

//counter on source CLK//	/////////////	////////////	////////////	////////////

//counter instantiation and port mapping//	/////////////	////////////	////////////	////////////
counter count(CLK_source,RST,async);

//BIT_SYNC instantiation and port mapping//	/////////////	////////////	////////////	////////////
DATA_SYNC #(num_stages,bus_width) DUT (
async,
CLK_destination,
RST, 
bus_enable,
sync,
enable_pulse
);

//TB code//	/////////////	////////////	////////////	////////////

initial begin
	$dumpfile("tb_DATA_SYNC.vcd");
	$dumpvars;
	CLK_destination	=0;
	CLK_source		=0;
	RST				=0;
	bus_enable		=0;
	#1
	RST				=1;
	
	#600
	$stop;
	
end



always#10 CLK_source = ~CLK_source;
always#1.2  CLK_destination = ~CLK_destination;

//simualting the ACK signal
always
begin
#10 bus_enable = ~bus_enable;
end


endmodule

