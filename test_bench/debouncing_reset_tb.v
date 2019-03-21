module debouncing_reset_tb();

	reg 	iclk;
	reg 	irst_n;
	wire	orst_n;
	
	debouncing_reset i0 (
		.iclk (iclk),
		.irst_n (irst_n),
		.orst_n (orst_n)
	);
	
	initial begin
		iclk 		= 0;
		irst_n	= 1;
	end
	
	always begin
		#10	iclk = ~iclk;
	end
	
	always begin
		$dumpfile("debouncing_reset.vcd");
		$dumpvars();
		#100	irst_n	= 0;
		#20		irst_n	= 1;
		#20		irst_n	=	0;
		#20		irst_n	= 1;
		#20		irst_n	=	0;
		#20		irst_n	= 1;
		#20		irst_n	=	0;
		#20		irst_n	= 1;
		#1000	$finish;
	end
	
endmodule
