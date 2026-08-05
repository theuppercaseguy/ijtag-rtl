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


//==============================================================================
// Interface   : jtag_inf
// Standard    : IEEE Std 1149.1
//
// Description:
//   Top-level JTAG interface connecting the Test Access Port (TAP) to the DUT.
//   Encapsulates all standard JTAG signals together with the Boundary Scan
//   Register (BSR) connections between the external pins and the core logic.
//
// Signal Flow:
//      Physical Input Pins
//              │
//              ▼
//      Input Boundary Scan Cells
//              │
//              ▼
//         Core Logic Inputs
//              │
//              ▼
//           Core Logic
//              │
//              ▼
//        Core Logic Outputs
//              │
//              ▼
//     Output Boundary Scan Cells
//              │
//              ▼
//      Physical Output Pins
//
// Notes:
//   • TCK is supplied as the interface clock.
//   • TDO is driven only during SHIFT_IR and SHIFT_DR.
//   • When BRIDGE_CORE is enabled, the core is bypassed by directly connecting
//     io_logic_in to io_logic_out.
//==============================================================================
import jtag_package::*;

interface jtag_inf (input logic tclk);

	logic tms, tdi, trst;                    // IEEE 1149.1 TAP inputs (TRST active-low)
	logic tdo;                               // IEEE 1149.1 TAP serial output

	logic [CORE_IN_PORTS-1:0] io_in;         // External input pins
	logic [CORE_IN_PORTS-1:0] io_logic_in;   // Input BSC outputs to core

	logic [CORE_OUT_PORTS-1:0] io_logic_out; // Core outputs to output BSCs
	logic [CORE_OUT_PORTS-1:0] io_out;       // Output BSC outputs to external pins

	generate
	if(BRIDGE_CORE)
		assign io_logic_out = io_logic_in;    // Bridge core input directly to core output
	endgenerate

endinterface : jtag_inf