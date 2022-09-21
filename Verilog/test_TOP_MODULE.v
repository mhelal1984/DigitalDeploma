`timescale		1us/10ns

module test_TOP_MODULE ();

reg		[15:0]	t_A,t_B;
reg		[3:0]	t_ALU_FUN;
reg				t_CLK,t_RST;
wire	[15:0]	t_arith_out,t_logic_out,t_shift_out;
wire	[1:0]	t_CMP_out;
wire			t_Arith_flag, t_Logic_flag, t_CMP_flag, t_Shift_flag;
wire			t_carry_out;

//DUT port mapping
TOP_MODULE_ALU #(.in_width(16),.out_width(16),.CMP_out_width(2))
DUT(
//inputs
.A              (t_A),
.B              (t_B),
.ALU_FUN        (t_ALU_FUN),
.CLK            (t_CLK),
.RST			(t_RST),

//outputs
.arith_out      (t_arith_out),
.carry_out      (t_carry_out),
.logic_out      (t_logic_out),
.CMP_out        (t_CMP_out),
.shift_out      (t_shift_out),
.arith_flag	    (t_Arith_flag),
.logic_flag     (t_Logic_flag),
.CMP_flag       (t_CMP_flag),
.shift_flag		(t_Shift_flag)
);


//CLK high for 6us and low for 4us , 
//giving a periode of 10us or 100KHZ frequency
//while the duty cycle is 60%
always 
begin
#6 t_CLK = 1'b0;
#4 t_CLK = !t_CLK;
end



initial
begin
	$dumpfile("_16bit_ALU.vcd");
	$dumpvars;
	//initial values
	t_A   = 16'b10100;//A = 20
	t_B   = 16'b00100;//B = 4
	t_CLK = 0;
	t_RST = 1;
	
//0000
	#3
	t_ALU_FUN = 4'b0000;	//addition
	#27
	if(t_arith_out == 16'b11000)
	begin
		$display ("TEST CASE 1 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 1 IS Failed") ;
	end

//0001
	#3
	t_ALU_FUN = 4'b0001;	//subtraction
	#27
	if(t_arith_out == 16'b10000)
	begin
		$display ("TEST CASE 2 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 2 IS Failed") ;
	end

//0010
	#3
	t_ALU_FUN = 4'b0010;	//multiplication
	#27
	if(t_arith_out == 16'b1010000)
	begin
		$display ("TEST CASE 3 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 3 IS Failed") ;
	end

//0011
	#3
	t_ALU_FUN = 4'b0011;	//division
	#27
	if(t_arith_out == 16'b101)
	begin
		$display ("TEST CASE 4 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 4 IS Failed") ;
	end

//0100
	#3
	t_ALU_FUN = 4'b0100;	//AND
	t_A= 16'b10010;
	t_B= 16'b10010;
	#27
	if(t_logic_out == 16'b10010)
	begin
		$display ("TEST CASE 5 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 5 IS Failed") ;
	end

//0101
	#3
	t_ALU_FUN = 4'b0101;	//OR
	t_A= 16'b10010;
	t_B= 16'b10011;
	#27
	if(t_logic_out == 16'b10011)
	begin
		$display ("TEST CASE 6 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 6 IS Failed") ;
	end

//0110
	#3
	t_ALU_FUN = 4'b0110;	//NAND
	t_A= 16'b10010;
	t_B= 16'b10010;
	#27
	if(t_logic_out == 16'b1111111111101101)
	begin
		$display ("TEST CASE 7 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 7 IS Failed") ;
	end

//0111
	#3
	t_ALU_FUN = 4'b0111;	//NOR
	t_A= 16'b10010;
	t_B= 16'b10010;
	#27
	if(t_logic_out == 16'b1111111111101101)
	begin
		$display ("TEST CASE 8 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 8 IS Failed") ;
	end

//1000
	#3
	t_ALU_FUN = 4'b1000;	//NO OP
	#27
	if(t_CMP_out == 2'b00)
	begin
		$display ("TEST CASE 9 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 9 IS Failed") ;
	end

//1001
	#3
	t_ALU_FUN = 4'b1001;	//equality
	t_A = 16'b10110111;
	t_B = 16'b10110111;
	#27
	if(t_CMP_out == 2'b01)
	begin
		$display ("TEST CASE 10 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 10 IS Failed") ;
	end

//1010
	#3
	t_ALU_FUN = 4'b1010;	//A larger than B
	t_A = 16'b100;
	t_B = 16'b010;
	#27
	if(t_CMP_out == 2'b10)
	begin
		$display ("TEST CASE 11 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 11 IS Failed") ;
	end

//1011
	#3
	t_ALU_FUN = 4'b1011;	//A smaller than B
	t_A = 16'b10100;
	t_B = 16'b11000;
	#27
	if(t_CMP_out == 2'b11)
	begin
		$display ("TEST CASE 12 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 12 IS Failed") ;
	end

//1100
	#3
	t_ALU_FUN = 4'b1100;	//Shift A right
	t_A = 16'b10101;
	#27
	if(t_shift_out == 16'b1010)
	begin
		$display ("TEST CASE 13 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 13 IS Failed") ;
	end

//1101
	#3
	t_ALU_FUN = 4'b1101;	//Shift A left
	t_A = 16'b10;
	#27
	if(t_shift_out == 16'b100)
	begin
		$display ("TEST CASE 14 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 14 IS Failed") ;
	end

//1110
	#3
	t_ALU_FUN = 4'b1110;	//shift B right
	t_B = 16'b10;
	#27
	if(t_shift_out == 16'b1)
	begin
		$display ("TEST CASE 15 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 15 IS Failed") ;
	end

//1111
	#3
	t_ALU_FUN = 4'b1111;	//shift B left
	t_B = 16'b1;
	#27
	if(t_shift_out == 16'b10)
	begin
		$display ("TEST CASE 16 IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE 16 IS Failed") ;
	end
  
  #20
  t_RST = 0;
  #1
  t_RST = 1;
  #1
  if((t_shift_out == 16'b0) & (t_logic_out == 0) & (t_arith_out == 0) & (t_CMP_out == 0))
	begin
		$display ("TEST CASE RESET IS PASSED") ;
	end
	else
	begin
		$display ("TEST CASE RESET IS Failed") ;
	end
  

#50 $stop;
end

endmodule
