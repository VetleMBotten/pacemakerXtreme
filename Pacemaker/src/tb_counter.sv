//-----------------------------------------------------------------------------
//
// Title       : tb_counter
// Design      : Pacemaker
// Author      : albertwf@stud.ntnu.no
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:/My_Designs/pacemakerTeller/tellerPace/src/pacemakerXtreme/Pacemaker/src/tb_counter.sv
// Generated   : Mon Nov  2 16:07:13 2026
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 	   laget av clude for testing av counter som jeg laget selv
//
//-----------------------------------------------------------------------------


//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {tb_counter}}

`timescale 1 ns / 1 ps
`default_nettype none

module tb_counter;

    logic clk = 0;
    logic R;
    wire  T;

    // Enhet som testes
    counter dut (.clk(clk), .R(R), .T(T));

    // 512 Hz klokke: periode 1 953 125 ns, halv periode 976 562,5 ns
    always #976562.5 clk = ~clk;

    realtime t_start, t_hoy;

    initial begin
        // --- Test 1: reset ---
        R = 1;
        repeat (3) @(posedge clk);
        #1;
        assert (dut.q === 10'd0)
            else $error("Reset virket ikke: q = %b", dut.q);
        $display("Test 1 OK: reset gir q = 0");		 
		#0.2e9;     // T er høy i 0,2 s

        // --- Test 2: tid til T ---
        R = 0;
        t_start = $realtime;
        @(posedge T);
        t_hoy = $realtime;
        $display("Test 2: T høy etter %.4f s, q = %0d",
			(t_hoy - t_start) * 1e-9, dut.q);		
		
	   
        // --- Test 3: reset mens T er høy ---
		#0.2e9;     // T er høy i 0,2 s
        R = 1;
		
        repeat (2) @(posedge clk);
        #1;
        assert (T === 1'b0 && dut.q === 10'd0)
            else $error("Reset fra T-tilstand feilet");
        $display("Test 3 OK: reset nullstiller T");	 
	   #0.2e9;     // T er høy i 0,2 s


        $finish; 
		

    end

    // Vakthund: stopper hvis T aldri kommer
    initial begin
        #3.0e9;      // 3 s
        $error("Timeout: T gikk aldri høy");
        $finish;
    end

endmodule

