
//tb signals instantiation
reg 	[4:0]	tb_IN;
reg				tb_load, tb_up, tb_down;
reg				tb_clk;
wire			tb_h_flag, tb_l_flag;
wire	[4:0]	tb_counter;

//port mapping
Up_Dn_Counter counter_1 (
	.IN			(tb_IN),
	.load		(tb_load),
	.up			(tb_up),
	.down		(tb_down),
	.h_flag		(tb_h_flag),
	.l_flag		(tb_l_flag),
	.counter	(tb_counter),
	.clk		(tb_clk)
);

