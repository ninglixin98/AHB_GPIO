# Begin_DVE_Session_Save_Info
# DVE view(Wave.1 ) session
# Saved on Wed Jul 27 20:41:15 2022
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 50 signals
# End_DVE_Session_Save_Info

# DVE version: O-2018.09-SP2_Full64
# DVE build date: Feb 28 2019 23:39:41


#<Session mode="View" path="/home/verifier/project/rkv_labs/AHB-GPIO/uvm/sim/rkv_gpio_debug_wave.do" type="Debug">

#<Database>

gui_set_time_units 1ps
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.1)
# DVE wave signals session
# Saved on Wed Jul 27 20:41:15 2022
# 50 signals
# End_DVE_Session_Save_Info

# DVE version: O-2018.09-SP2_Full64
# DVE build date: Feb 28 2019 23:39:41


#Add ncecessay scopes
gui_load_child_values {rkv_gpio_tb.ahb_if}
gui_load_child_values {rkv_gpio_tb.dut}
gui_load_child_values {rkv_gpio_tb.gpio_if}

gui_set_time_units 1ps

set _wave_session_group_1 Group3
if {[gui_sg_is_group -name "$_wave_session_group_1"]} {
    set _wave_session_group_1 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_1"

gui_sg_addsignal -group "$_wave_session_group_1" { {Sim:rkv_gpio_tb.dut.ECOREVNUM} }

set _wave_session_group_2 $_wave_session_group_1|
append _wave_session_group_2 PORT
set Group3|PORT "$_wave_session_group_2"

gui_sg_addsignal -group "$_wave_session_group_2" { {Sim:rkv_gpio_tb.dut.PORTIN} {Sim:rkv_gpio_tb.dut.PORTOUT} {Sim:rkv_gpio_tb.dut.PORTEN} {Sim:rkv_gpio_tb.dut.PORTFUNC} }

set _wave_session_group_3 $_wave_session_group_1|
append _wave_session_group_3 INTQ
set Group3|INTQ "$_wave_session_group_3"

gui_sg_addsignal -group "$_wave_session_group_3" { {Sim:rkv_gpio_tb.dut.GPIOINT} {Sim:rkv_gpio_tb.dut.COMBINT} }

gui_sg_move "$_wave_session_group_3" -after "$_wave_session_group_1" -pos 1 

set _wave_session_group_4 $_wave_session_group_1|
append _wave_session_group_4 AHB
set Group3|AHB "$_wave_session_group_4"

gui_sg_addsignal -group "$_wave_session_group_4" { {Sim:rkv_gpio_tb.dut.HCLK} {Sim:rkv_gpio_tb.dut.HRESETn} {Sim:rkv_gpio_tb.dut.FCLK} {Sim:rkv_gpio_tb.dut.HSEL} {Sim:rkv_gpio_tb.dut.HREADY} {Sim:rkv_gpio_tb.dut.HTRANS} {Sim:rkv_gpio_tb.dut.HSIZE} {Sim:rkv_gpio_tb.dut.HWRITE} {Sim:rkv_gpio_tb.dut.HADDR} {Sim:rkv_gpio_tb.dut.HWDATA} {Sim:rkv_gpio_tb.dut.HREADYOUT} {Sim:rkv_gpio_tb.dut.HRESP} {Sim:rkv_gpio_tb.dut.HRDATA} }

gui_sg_move "$_wave_session_group_4" -after "$_wave_session_group_1" -pos 2 

set _wave_session_group_5 AHB-IF
if {[gui_sg_is_group -name "$_wave_session_group_5"]} {
    set _wave_session_group_5 [gui_sg_generate_new_name]
}
set Group2 "$_wave_session_group_5"

gui_sg_addsignal -group "$_wave_session_group_5" { {Sim:rkv_gpio_tb.ahb_if.hclk} {Sim:rkv_gpio_tb.ahb_if.hresetn} {Sim:rkv_gpio_tb.ahb_if.hgrant} {Sim:rkv_gpio_tb.ahb_if.hrdata} {Sim:rkv_gpio_tb.ahb_if.hready} {Sim:rkv_gpio_tb.ahb_if.hresp} {Sim:rkv_gpio_tb.ahb_if.haddr} {Sim:rkv_gpio_tb.ahb_if.hsize} {Sim:rkv_gpio_tb.ahb_if.htrans} {Sim:rkv_gpio_tb.ahb_if.hwdata} {Sim:rkv_gpio_tb.ahb_if.hwrite} {Sim:rkv_gpio_tb.ahb_if.hburst} {Sim:rkv_gpio_tb.ahb_if.hbusreq} {Sim:rkv_gpio_tb.ahb_if.hlock} {Sim:rkv_gpio_tb.ahb_if.hprot} {Sim:rkv_gpio_tb.ahb_if.debug_hresp} {Sim:rkv_gpio_tb.ahb_if.debug_htrans} {Sim:rkv_gpio_tb.ahb_if.debug_hsize} {Sim:rkv_gpio_tb.ahb_if.debug_hburst} {Sim:rkv_gpio_tb.ahb_if.debug_xact} {Sim:rkv_gpio_tb.ahb_if.debug_status} }

set _wave_session_group_6 GPIO-IF
if {[gui_sg_is_group -name "$_wave_session_group_6"]} {
    set _wave_session_group_6 [gui_sg_generate_new_name]
}
set Group3 "$_wave_session_group_6"

gui_sg_addsignal -group "$_wave_session_group_6" { {Sim:rkv_gpio_tb.gpio_if.clk} {Sim:rkv_gpio_tb.gpio_if.fclk} {Sim:rkv_gpio_tb.gpio_if.rstn} {Sim:rkv_gpio_tb.gpio_if.portin} {Sim:rkv_gpio_tb.gpio_if.portout} {Sim:rkv_gpio_tb.gpio_if.porten} {Sim:rkv_gpio_tb.gpio_if.portfunc} {Sim:rkv_gpio_tb.gpio_if.gpioint} {Sim:rkv_gpio_tb.gpio_if.combint} }
if {![info exists useOldWindow]} { 
	set useOldWindow true
}
if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
	set Wave.1 [gui_get_current_window -view] 
} else {
	set Wave.1 [lindex [gui_get_window_ids -type Wave] 0]
if {[string first "Wave" ${Wave.1}]!=0} {
gui_open_window Wave
set Wave.1 [ gui_get_current_window -view ]
}
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 0 913
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group1}]
gui_list_add_group -id ${Wave.1}  -after ${Group1} [list ${Group3|PORT}]
gui_list_add_group -id ${Wave.1} -after Group3|PORT [list ${Group3|INTQ}]
gui_list_add_group -id ${Wave.1} -after Group3|INTQ [list ${Group3|AHB}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group2}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group3}]
gui_list_select -id ${Wave.1} {rkv_gpio_tb.dut.ECOREVNUM }
gui_seek_criteria -id ${Wave.1} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group ${Group3}  -position in

gui_marker_move -id ${Wave.1} {C1} 0
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
#</Session>

