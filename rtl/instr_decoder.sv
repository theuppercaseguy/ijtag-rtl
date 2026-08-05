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

module instr_decoder import jtag_package::*;
	#(parameter IR_WIDTH = 4)
(
	input logic [IR_WIDTH-1:0] ir_reg,
 	
	output logic ijtag_sib_sel,
	output logic mode_ctrl,
	output tdr_avlbl_t tdr_selected
);
	always_comb begin
		case (ir_reg) //mode values defined by IEEE
	 	EXTEST: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl 	  = 1;
	 		tdr_selected  = TDR_BSR;
	 	end
	 	IDCODE: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_IDCODE;
	 	end
	 	INTEST: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 1;
	 		tdr_selected  = TDR_BSR;
	 	end
	 	PRELOAD: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_BSR;
	 	end
	 	RUNBIST: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 1;
	 		tdr_selected  = TDR_RUNBIST;
	 	end
	 	SAMPLE: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_BSR;
	 	end
	 	BYPASS: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_BYPASS;
	 	end 
	 	CLAMP: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 1;
	 		tdr_selected  = TDR_BYPASS;
	 	end
	 	HIGHZ: begin
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_BYPASS;
	 	end 
	 	IJTAG_INST: begin
	 		ijtag_sib_sel = 1;
	 		mode_ctrl     = 0;
	 		tdr_selected  = IJTAG_NETWORK;
	 	end 
	 
	 	default : begin 
	 		ijtag_sib_sel = 0;
	 		mode_ctrl     = 0;
	 		tdr_selected  = TDR_IDCODE;
	 	end
		endcase
	end

endmodule : instr_decoder