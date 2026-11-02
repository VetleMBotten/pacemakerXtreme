//-----------------------------------------------------------------------------
//
// Title       : counter
// Design      : Pacemaker
// Author      : albertwf@stud.ntnu.no
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:/My_Designs/pacemakerTeller/tellerPace/src/pacemakerXtreme/Pacemaker/src/counter.v
// Generated   : Fri Oct 30 13:10:12 2026
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {counter}}

module counter (
	input clk,
	input R,
	output wire T	    
	);

//}} End of automatically maintained section		 
wire r_n;	
wire [9:0] q, q_n; 
wire t_n;

not g_1 (r_n, R);		

d_flipflop ffp_Q_0 (		  //må initiere Q_0 for at den har andeleedes inn på CLK en de andre 
	.clk	  (clk),
	.D		(q_n[0]),
	.R_n (r_n),
	.Q	(q[0]),			  	//utgang
	.Q_n	(q_n[0]) 			//invertert utgang
);	

for (genvar i = 1; i < 10; i++) begin : g_trinn
	d_flipflop ffp_Q_1 (
		.clk	  (q_n[i-1]),
		.D		(q_n[i]),
		.R_n (r_n),
		.Q	(q[i]),			  	//utgang
		.Q_n	(q_n[i]) 			//invertert utgang
	);
	end
	

	
// T = q[9] and q[8]	  
nand G1 (t_n, q[9], q[8]);	  
not G2 (T, t_n);

// Enter your statements here //

endmodule
