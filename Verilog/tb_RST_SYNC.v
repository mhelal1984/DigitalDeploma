`timescale 1ns/1ps

module tb_RST_SYNC #(parameter NUM_STAGES = 2)();
reg		CLK,RST;
wire	SYNC_RST;


RST_SYNC #(NUM_STAGES) DUT (
CLK,
RST,
SYNC_RST
);

initial begin
	$dumpfile("tb_RST_SYNC.vcd");
	$dumpvars;
	CLK		= 0;
	RST		= 1;
	
	#1000 
	$stop;
end

always #5 CLK = ~CLK;

// RST signal coming periodically for 1ns every 54 ns
always 
begin
#1	RST = 1;
#53 	RST = 0;
#1 	RST = 1;
end

endmodule
