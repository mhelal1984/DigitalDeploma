`timescale 10ns / 1ps

module tb_FSM_DOOR;

	// Inputs
	reg CLK;
	reg RST;
	reg Activate;
	reg UP_MAX;
	reg DN_MAX;

	// Outputs
	wire UP_motor;
	wire DN_motor;

	// Instantiate the Unit Under Test (UUT)
	FSM_DOOR uut (
		.CLK(CLK), 
		.RST(RST), 
		.Activate(Activate), 
		.UP_MAX(UP_MAX), 
		.DN_MAX(DN_MAX), 
		.UP_motor(UP_motor), 
		.DN_motor(DN_motor)
	);
	
initial 
begin
	// Initialize Inputs
	CLK         = 0;
	RST         = 0;
	Activate    = 0;
	UP_MAX      = 0;
	DN_MAX      = 0;
	#2
	RST         = 1;
	#22
	if(!UP_motor && !DN_motor)
	begin
	$display("RESET Working Fine : TEST PASSED");
	end
	
	else
	begin
	$display("RESET isn't working: TEST FAILED");
	end
	#1
	Activate    = 1;
	UP_MAX      = 1;
	#29
	if(!UP_motor && DN_motor)
	begin
	$display("DN_motor Working Fine : TEST PASSED");
	end
	
	else
	begin
	$display("DN_motor isn't working: TEST FAILED");
	end
	#1
	UP_MAX      = 0;
	#30
	DN_MAX      = 1;
	#29
	if(UP_motor && !DN_motor)
	begin
	$display("UP_motor Working Fine : TEST PASSED");
	end
	
	else
	begin
	$display("UP_motor isn't working: TEST FAILED");
	end
	#1
	DN_MAX      = 0;
	#30
	Activate    = 0;
	#5
	UP_MAX      = 1;
	#14
	if(!UP_motor && !DN_motor)
	begin
	$display("BACK TO IDLE: TEST PASSED");
	end
	
	else
	begin
	$display("BACK TO IDLE: TEST FAILED");
	end
	#1
	UP_MAX      = 0;
#100;
$stop;
end

always #2.5 CLK = ~CLK;

endmodule