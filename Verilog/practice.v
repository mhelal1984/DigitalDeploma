//all ports at once beside module name
//all lines end with semicolon ";"
module practice (A, B, C, D, E);


//define each port, default type is wire and signals 
//are defined directly as their own type
//if you want to change a port type you redefine its type

output	D, E;
input	A, B, C;
wire	w1;


//structural code using primitevs sate(o/p, i/ps)
//propagation delay is done using "#" sign

and		#(30) G1 (w1, A, B);
not		#(10) G2 (E, C);
or		#(20) G3 (D, w1, E);

endmodule
