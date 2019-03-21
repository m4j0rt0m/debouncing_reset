module debouncing_reset (iclk, irst_n, orst_n);

	input iclk;
	input irst_n;
	output reg orst_n = 0;

	reg [2:0]	cnt = 0;
	reg [2:0]	fsm = 0;
		localparam StateIdle 							=	3'b000;
		localparam StateInitialDebouncing =	3'b011;
		localparam StateFinalDebouncing	 	=	3'b101;
//		`ifndef SYNTHESIS
			initial fsm = StateIdle;
//		`endif

	always @ (posedge iclk)	begin
		case(fsm)
			StateIdle:	begin
				if(~irst_n)	begin
					orst_n <= 1'b0;
					fsm 	 <=	StateInitialDebouncing;
				end
				else
					orst_n <= 1'b1;
				cnt <= 0;
			end
			StateInitialDebouncing:		begin
				if(&cnt)	begin
					if(irst_n)	begin
						orst_n	<=	1'b1;
						fsm 		<=	StateFinalDebouncing;
					end
				end
				cnt 		<= cnt + 1;
			end
			StateFinalDebouncing:	begin
				if(&cnt)
					fsm 		<=	StateIdle;
				cnt 		<= cnt + 1;
			end
			default: fsm <= StateIdle;
		endcase
	end

endmodule
