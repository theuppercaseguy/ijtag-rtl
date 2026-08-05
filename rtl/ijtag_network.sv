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

module ijtag_network import jtag_package::*; #(
	parameter TDR1_WIDTH = `TDR1_WIDTH, parameter TDR1_RST_VAL = `TDR1_RST_VAL,
	parameter TDR2_WIDTH = `TDR2_WIDTH, parameter TDR2_RST_VAL = `TDR2_RST_VAL,
	parameter TDR3_WIDTH = `TDR3_WIDTH, parameter TDR3_RST_VAL = `TDR3_RST_VAL,
	parameter TDR4_WIDTH = `TDR4_WIDTH, parameter TDR4_RST_VAL = `TDR4_RST_VAL,
	parameter TDR5_WIDTH = `TDR5_WIDTH, parameter TDR5_RST_VAL = `TDR5_RST_VAL
	)(
	input  logic tclk,       // JTAG test clock
	input  logic trst_n,     // Active-low asynchronous reset

	input  logic tdi,        // Scan input from TAP
	input  logic tap_sel,    // Root select from TAP
	input  logic capture_dr, // Capture-DR state
	input  logic shift_dr,   // Shift-DR state
	input  logic update_dr,  // Update-DR state

	output logic tdo         // Scan output back to TAP
);
	// Internal SIB/TDR interconnect signals
	logic sib1_si, sib1_so, tdr1_si, tdr1_so, sib1_sel, sib1_to_sel, sib1_val;
	logic sib2_si, sib2_so, tdr2_si, tdr2_so, sib2_sel, sib2_to_sel, sib2_val;
	logic sib3_si, sib3_so, tdr3_si, tdr3_so, sib3_sel, sib3_to_sel, sib3_val;
	logic sib4_si, sib4_so, tdr4_si, tdr4_so, sib4_sel, sib4_to_sel, sib4_val;
	logic sib5_si, sib5_so, tdr5_si, tdr5_so, sib5_sel, sib5_to_sel, sib5_val;
	logic sib6_si, sib6_so, tdr6_si, tdr6_so, sib6_sel, sib6_to_sel, sib6_val;

	// Scan connection from SIB3 into its child branch
	logic sib3_to_sib5_si;

	//============================================================
	// Root SIB-1
	//============================================================
	assign sib1_si  = tdi;
	assign sib1_sel = tap_sel;
	sib sib_1(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib1_sel		),
		.si 		  (sib1_si 		),
		.from_so	  (tdr1_so		),

		.so    		  (sib1_so  	),
		.to_si 		  (tdr1_si	  	),
		.to_sel		  (sib1_to_sel	),
		.sib_val	  (sib1_val 	)
	);

	// TDR behind SIB-1
	shift_register #(.WIDTH(TDR1_WIDTH))
	tdr_1(
		.clk     (tclk),
		.rst_n   (trst_n),
		.state   (sib1_val ? ( capture_dr ? PAR_IN : (shift_dr ? SER_IN : DISABLE) ) : DISABLE ),

		.ser_in  (tdr1_si),
		.par_in  (TDR1_RST_VAL),

		.ser_out (tdr1_so),
		.par_out ()
	);

	//============================================================
	// Root SIB-2
	//============================================================
	assign sib2_sel = tap_sel;
	sib sib_2(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib2_sel		),
		.si 		  (sib1_so 		),
		.from_so	  (tdr2_so		),

		.so    		  (sib2_so  	),
		.to_si 		  (tdr2_si	  	),
		.to_sel		  (sib2_to_sel	),
		.sib_val	  (sib2_val		)
	);

	// TDR behind SIB-2
	shift_register #(.WIDTH(TDR2_WIDTH))
	tdr_2(
		.clk     (tclk),
		.rst_n   (trst_n),
		.state   ( sib2_val ? ( capture_dr ? PAR_IN : (shift_dr ? SER_IN : DISABLE) ) : DISABLE ),

		.ser_in  (tdr2_si),
		.par_in  (TDR2_RST_VAL),

		.ser_out (tdr2_so),
		.par_out ()
	);

	//============================================================
	// Root SIB-3 (Parent of SIB-5 and SIB-6)
	//============================================================
	assign sib3_sel = tap_sel;
	sib sib_3(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib3_sel		),
		.si 		  (sib2_so 		),
		.from_so	  (sib6_so      ),

		.so    		  (sib3_so  	),
		.to_si 		  (sib3_to_sib5_si),
		.to_sel		  (sib3_to_sel	),
		.sib_val	  (sib3_val		)
	);

	//============================================================
	// SIB-5 - Child of SIB-3
	//============================================================
	assign sib5_sel = sib3_to_sel;
	sib sib_5(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib5_sel		),
		.si 		  (sib3_to_sib5_si),
		.from_so	  (tdr3_so  	),

		.so    		  (sib5_so  	),
		.to_si 		  (tdr3_si	  	),
		.to_sel		  (sib5_to_sel	),
		.sib_val	  (sib5_val		)
	);
	// TDR behind SIB-5
	shift_register #(.WIDTH(TDR3_WIDTH))
	tdr_3(
		.clk     (tclk),
		.rst_n   (trst_n),
		.state   ( sib5_val ? ( capture_dr ? PAR_IN : (shift_dr ? SER_IN : DISABLE) ) : DISABLE ),

		.ser_in  (tdr3_si),
		.par_in  (TDR3_RST_VAL),

		.ser_out (tdr3_so),
		.par_out ()
	);

	//============================================================
	// SIB-6 - Child of SIB-3
	//============================================================
	assign sib6_sel = sib3_to_sel;
	sib sib_6(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib6_sel		),
		.si 		  (sib5_so),
		.from_so	  (tdr4_so  	),

		.so    		  (sib6_so  	),
		.to_si 		  (tdr4_si	  	),
		.to_sel		  (sib6_to_sel	),
		.sib_val	  (sib6_val		)
	);

	// TDR behind SIB-6
	shift_register #(.WIDTH(TDR4_WIDTH))
	tdr_4(
		.clk     (tclk),
		.rst_n   (trst_n),
		.state   ( sib6_val ? ( capture_dr ? PAR_IN : (shift_dr ? SER_IN : DISABLE) ) : DISABLE ),

		.ser_in  (tdr4_si),
		.par_in  (TDR4_RST_VAL),

		.ser_out (tdr4_so),
		.par_out ()
	);

	//============================================================
	// Root SIB-4
	//============================================================
	assign sib4_sel = tap_sel;
	sib sib_4(
		.tclk		  (tclk			),
		.trst_n		  (trst_n		),
		.capture_en	  (capture_dr	),
		.shift_en	  (shift_dr		),
		.update_en	  (update_dr	),

		.sel		  (sib4_sel		),
		.si 		  (sib3_so),
		.from_so	  (tdr5_so  	),

		.so    		  (sib4_so  	),
		.to_si 		  (tdr5_si	  	),
		.to_sel		  (sib4_to_sel	),
		.sib_val	  (sib4_val		)
	);

	// TDR behind SIB-4
	shift_register #(.WIDTH(TDR5_WIDTH))
	tdr_5(
		.clk     (tclk),
		.rst_n   (trst_n),
		.state   ( sib4_val ? ( capture_dr ? PAR_IN : (shift_dr ? SER_IN : DISABLE) ) : DISABLE ),

		.ser_in  (tdr5_si),
		.par_in  (TDR5_RST_VAL),

		.ser_out (tdr5_so),
		.par_out ()
	);

	// Final scan output back to TAP
	assign tdo = sib4_so;

endmodule : ijtag_network