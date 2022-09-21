`timescale 1ns/10ps

module tb_BIT_SYNC #(parameter num_stages = 5, 
parameter bus_width	 = 4)();

//interface ports//	/////////////	////////////	////////////	////////////
reg								RST, CLK_destination, CLK_source;
wire		[bus_width-1:0]		async;
wire		[bus_width-1:0]		sync;

//counter on source CLK//	/////////////	////////////	////////////	////////////
module counter(
input		wire				 		CLK_source_count,RST_counter,
output		reg		[bus_width-1:0]		OUT
);

always@(posedge CLK_source_count,negedge RST_counter)
OUT <=(!RST_counter)? 'b0 : (OUT + 1);
endmodule

//counter instantiation and port mapping//	/////////////	////////////	////////////	////////////
counter count(CLK_source,RST,async);

//BIT_SYNC instantiation and port mapping//	/////////////	////////////	////////////	////////////
BIT_SYNC #(3,bus_width) DUT (
RST, 
CLK_destination,
async,
sync
);

//TB code//	/////////////	////////////	////////////	////////////

initial begin
	$dumpfile("tb_BIT_SYNC.vcd");
	$dumpvars;
	CLK_destination	=0;
	CLK_source		=0;
	RST				=0;
	#1
	RST				=1;
	
	#400
	$stop;
	
end



always#10 CLK_source = ~CLK_source;
always#1.2  CLK_destination = ~CLK_destination;

endmodule

