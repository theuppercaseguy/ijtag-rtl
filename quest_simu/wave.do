onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group jtag_inf /ijtag_tb_top/jtag_intf/trst
add wave -noupdate -expand -group jtag_inf /ijtag_tb_top/jtag_intf/tclk
add wave -noupdate -expand -group jtag_inf /ijtag_tb_top/jtag_intf/tms
add wave -noupdate -expand -group jtag_inf /ijtag_tb_top/jtag_intf/tdi
add wave -noupdate -expand -group jtag_inf /ijtag_tb_top/jtag_intf/tdo
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/tap_fsm_curr_state
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/capture_en
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/shift_en
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/update_en
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib1_val
add wave -noupdate /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib2_val
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/instr_reg/tdi
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/instr_reg/tclk
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/instr_reg/trst_n
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/instr_reg/tap_fsm_curr_state
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/instr_reg/tdo
add wave -noupdate -group instr_reg /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/trst_n
add wave -noupdate -group decoder -radix binary /ijtag_tb_top/ijtag_top_inst/instr_reg/shift_reg
add wave -noupdate -group decoder -radix binary /ijtag_tb_top/ijtag_top_inst/instr_reg/ir_hold_reg
add wave -noupdate -group decoder /ijtag_tb_top/ijtag_top_inst/instr_decoder_i/tdr_selected
add wave -noupdate -group decoder /ijtag_tb_top/ijtag_top_inst/instr_decoder_i/mode_ctrl
add wave -noupdate -group decoder /ijtag_tb_top/ijtag_top_inst/instr_decoder_i/ijtag_sib_sel
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/si
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/so
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/to_si
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/from_so
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/sel
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/to_sel
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/cap_reg
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/upd_reg
add wave -noupdate -group SIB_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_1/sib_val
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/si
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/so
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/to_si
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/from_so
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/sel
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/to_sel
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/cap_reg
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/upd_reg
add wave -noupdate -group SIB_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/sib_2/sib_val
add wave -noupdate -expand -group TDR_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_1/ser_in
add wave -noupdate -expand -group TDR_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_1/state
add wave -noupdate -expand -group TDR_1 -radix binary /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_1/shift_reg
add wave -noupdate -expand -group TDR_1 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_1/ser_out
add wave -noupdate -expand -group TDR_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_2/state
add wave -noupdate -expand -group TDR_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_2/ser_in
add wave -noupdate -expand -group TDR_2 -radix binary /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_2/shift_reg
add wave -noupdate -expand -group TDR_2 /ijtag_tb_top/ijtag_top_inst/ijtag_netwrok/tdr_2/ser_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2550000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1864668 ps} {3341947 ps}
