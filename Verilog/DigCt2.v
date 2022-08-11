// Sorry for the inconvenience I already did the same code for the previous assignment 😅 

module DigCt (

	input	wire	IN1, IN2, IN3, IN4, IN5,
	input	wire	CLK,
	output	reg		OUT1, OUT2, OUT3
	
	);

reg sig1, sig2, sig3;

always@(IN1 or IN2)
	begin
		sig1 = ~((~(IN1|IN2))&IN3);
	end

always@(IN2 or IN3)
	begin
		sig2 = ~(IN2&IN3);
	end

always@(IN3 or IN4 or IN5)
	begin
		sig3 = (IN3|(~IN4))|IN5;
	end

always@(posedge)
	begin
		OUT1 <= sig1;
		OUT2 <= sig2;
		OUT3 <= sig3;
	end

endmodule