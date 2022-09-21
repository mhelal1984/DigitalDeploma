module FSM_DOOR(
input		wire			CLK,RST,
input		wire			Activate,
input		wire			UP_MAX,DN_MAX,
output	reg			UP_motor,DN_motor
);

localparam		S0 = 2'b00,		//IDLE				///////////////////
				S1 = 2'b01,		//Move Up			///state encoding//
				S2 = 2'b10;		//Move Down			///////////////////

reg		[1:0]		current_state,next_state;

always@(posedge CLK, negedge RST)
begin
	if(!RST)
	begin
		current_state <= S0;
	end
	
	else
	begin
		current_state <= next_state;
	end
end

always@(*)
begin
	UP_motor = 0;
	DN_motor = 0;
	case(current_state)

		S0:	begin		//idle
				UP_motor = 1'b0;
				DN_motor = 1'b0;
				case({Activate,UP_MAX,DN_MAX})
					//3'b100:next_state = S1;
					3'b101:next_state = S1;
					3'b110:next_state = S2;
					default:next_state= S0;
				endcase
			end
		
		S1:	begin		//move up
				UP_motor = 1'b1;
				next_state = UP_MAX ? S0:S1;
			end
		
		S2:	begin		//move down
				DN_motor = 1'b1;
				next_state = DN_MAX ? S0:S2;
			end
		
	default:begin
				next_state = S0;
			end
		endcase
end

endmodule