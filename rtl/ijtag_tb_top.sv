//==============================================================================
//  Project    : IEEE 1149.1 JTAG / IEEE 1687 IJTAG RTL Implementation
//  Author     : Saad Khan
//  Email      : saadan06@gmail.com
//  GitHub     : https://github.com/theuppercaseguy
//  LinkedIn   : https://www.linkedin.com/in/the-guy/
//  Portfolio  : https://portfolio-saadkhan.vercel.app/
//------------------------------------------------------------------------------
//  Copyright (c) Saad Khan.
//
//  This project is open for educational, research, and commercial use.
//  Redistribution and modification are permitted, provided appropriate
//  credit is given to the original author and this repository is referenced.
//==============================================================================

`timescale 1ns/1ps
module ijtag_tb_top;

	import jtag_package::*;
	logic clk, rst;

	jtag_inf jtag_intf(clk);

	ijtag_top ijtag_top_inst(
		.inf(jtag_intf)
	);

	initial begin
		jtag_intf.trst = 0; //rst enabled at startup
		clk = 0;
		forever #50ns clk = ~clk;
		// #150 jtag_intf.trst = 1; //rst deactivated
	end

	initial begin
	    // Defaults
	    jtag_intf.trst = 0;
	    jtag_intf.tms  = 1'bz;
	    jtag_intf.tdi  = 1'bz;

	    // Hold reset for a few cycles
	    repeat (2) @(posedge clk);
	    jtag_intf.trst = 1;

	    //----------------------------------------------------------
	    // Move to Shift-IR
	    //----------------------------------------------------------
	    jtag_cycle(0,1'bz);   // RST
	    jtag_cycle(1,1'bz);   // Run-Test/Idle
	    jtag_cycle(1,1'bz);   // Select-DR
	    jtag_cycle(0,1'bz);   // Select-IR
	    jtag_cycle(0,1'bz);   // Capture-IR

	    //----------------------------------------------------------
	    // Shift IR = 10001110 (LSB first)
	    //----------------------------------------------------------
	    jtag_cycle(0,0);
	    jtag_cycle(0,1);
	    jtag_cycle(0,1);
	    jtag_cycle(0,1);
	    jtag_cycle(0,0);
	    jtag_cycle(0,0);
	    jtag_cycle(0,0);

	    //----------------------------------------------------------
	    // Exit / Update IR
	    //----------------------------------------------------------
	    jtag_cycle(1,1'b0);   // Exit1-IR
	    jtag_cycle(1,1'bz);   // Update-IR
	    jtag_cycle(1,1'bz);   // Select-DR

	    //----------------------------------------------------------
	    // DR transaction - Opening SIB-3 only, to be able program SIB5 and SIB6 without haveing to go through SIB-1, SIB-2, and SIB-5 TDR's
	    //----------------------------------------------------------
	    jtag_cycle(0,1'bz);   // Capture-DR
	    jtag_cycle(0,1'bz);   // Shift-DR
	    jtag_cycle(0,1'b0);   // Shift-DR  -- SIB 4 closed
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 3 Opened
	    jtag_cycle(0,1'b0);   // Shift-DR  -- SIB 2 closed
	    jtag_cycle(1,1'b0);   // Exit1-DR  -- SIB 1 closed
	    jtag_cycle(1,1'bz);   // Update-DR

	    //----------------------------------------------------------
	    // DR transaction - Opening SIB 1, 2, 3, 4, 5 and 6
	    //----------------------------------------------------------
	    jtag_cycle(1,1'bz);   // Select-DR
	    jtag_cycle(0,1'bz);   // Capture-DR
	    jtag_cycle(0,1'bz);   // Shift-DR
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 6 Opened
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 5 Opened
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 4 Opened
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 3 Opened
	    jtag_cycle(0,1'b1);   // Shift-DR  -- SIB 2 Opened
	    jtag_cycle(1,1'b1);   // Exit1-DR  -- SIB 1 Opened
	    jtag_cycle(1,1'bz);   // Update-DR

	    //----------------------------------------------------------
	    // Second DR transaction - Shifting value(TDI) into ALL TDR's
	    //----------------------------------------------------------
	    jtag_cycle(1,1'bz);   // Select-DR
	    jtag_cycle(0,1'bz);   // Capture-DR
	    jtag_cycle(0,1'bz);   // Shift-DR

	    repeat (8*5 + 6)
        jtag_cycle(0,1'b1);   // Shifting 1'b1 into all TDR's

	    repeat (8)
        jtag_cycle(0,1'b0);  // Shifting 1'b0 into TDR-1
        
	    //----------------------------------------------------------
	    // Return to Idle
	    //----------------------------------------------------------
	    jtag_cycle(1,1'bz);
	    jtag_cycle(1,1'bz);
	    jtag_cycle(0,1'bz);
	    jtag_cycle(0,1'bz);
	    jtag_cycle(0,1'bz);

	    $finish;
	end 

	task automatic jtag_cycle(input logic tms, input logic tdi);

    @(negedge clk);
    jtag_intf.tms <= tms;
    jtag_intf.tdi <= tdi;
    @(posedge clk);

endtask
endmodule : ijtag_tb_top