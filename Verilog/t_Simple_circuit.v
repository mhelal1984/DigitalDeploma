`timescale 1 ns/ 100 ps

module t_Simple_Circuit;
	wire	D, E;
	reg		A, B, C;
	
	Simple_Circuit M1 (A, B, C, D, E);
	
	initial
		begin
			A = 1'b0; B = 1'b0; C = 1'b0;
			#100 A = 1'b1; B = 1'b1; C = 1'b1;
			#100 $finish;
		end
	
	initial $monitor ($time , , 
	"A = 5b B = %b C = %b w1 = %b D w1 = %b E w1 = %b",
	A, B, C, M1.w1, D, E);
	
endmodule