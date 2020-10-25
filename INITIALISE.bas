' variable declaration for VRs and I/Os
' VR table mapping
' 0 - 50  machine specific : values to be set from HMI
' 51 - 60 machine specific : commands to be send from HMI
' 61 - 99 machine specific : status values send to HMI
' 101 - 230 axis0 to axis7 specific parameters
' 231 - 250 reserved for template
' 250 - 300 unused
' 300 - 350 internal used
' 351 - 400 error handling
' 401 - 1000 machine specific : unused


' ***********************************
'           Input/Output declaration
' ***********************************

 ' ADD YOUR IO LIST

estop = 7

' outputs specific to machine state

 home_ok=64 ' VIRTUAL


' alarms on virtual outputs
 alm0 = 99 ' any alamr active
 alm1 = 100 ' alarm 1
 alm2 = 101 ' alarm 2
 alm3 = 102 ' alarm 3
 alm4 = 103 ' alarm 4
 alm5 = 103 ' MANUAL Programm stopped running
 alm6 = 104 ' AUTOM Programm stopped running
 alm7 = 105 ' VR_SET Programm stopped running
 alm8 = 106 ' STARTUP Programm stopped running

 o_error = 69

 feed_hold_in = 201


' Machine specific parameters
' ADD YOUR VR variables



' VR Specific to machine cycle
'estop = 50 'Emergancy stop
 enable = 51
 manual = 52
 jog_fwd = 53
 jog_rev = 54
 home_start = 55
 auto = 56


'Ethercat Operation
 ethercat_stat = 59
 no_of_ecat_axes = 60

 x_pos_hmi=70 'x pos display
 y_pos_hmi=73 'y pos display
 z_pos_hmi=77 'z pos display

'VRs specific to axis

'******************************
'***VR 101 to 120 for Axis 0***
'******************************
 enc_cnt_ax0 = 101 ' axis 0 encoder counts per rotation
 dia_ax0 = 102 ' axis 0 diameter in mm
 gb_ax0 = 103 ' axis 0 Gear Ratio ( assumption isGB > 1)
 speed_ax0 = 104 ' axis 0 speed
 accel_ax0 = 105 ' axis 0 accel
 decel_ax0 = 106 ' axis 0 decel
 creep_ax0 = 107 ' axis 0 homing slow speed
 fdecel_ax0 = 108 ' axis 0 fast deceleration rate
 jspeed_ax0 = 109 ' axis 0 jog speed
 dir_0 = 110 ' axis 0 encoder direction inversion 1= yes, 0 = no
 dat_mode_0 = 111 ' axis 0 datuming/homing mode
 dat_off_0 = 112 ' axis 0 datuming/homing offset
 fact0 = 113 ' multiplying factor for converting user units to counts

'******************************
'***VR 121 to 140 for Axis 1***
'******************************
 enc_cnt_ax1 = 121 ' axis 1 encoder counts per rotation
 dia_ax1 = 122 ' axis 1 diameter in mm
 gb_ax1 = 123 ' axis 1 Gear Ratio ( assumption isGB > 1)
 speed_ax1 = 124 ' axis 1 speed
 accel_ax1 = 125 ' axis 1 accel
 decel_ax1 = 126 ' axis 1 decel
 creep_ax1 = 127 ' axis 1 homing slow speed
 fdecel_ax1 = 128 ' axis 1 fast deceleration rate
 jspeed_ax1 = 129 ' axis 1 jog speed
 dir_1 = 130 ' axis 1 encoder direction inversion 1= yes, 0 = no
 dat_mode_1 = 131 ' axis 1 datuming/homing mode
 dat_off_1 = 132 ' axis 1 datuming/homing offset
 fact1 = 133 ' multiplying factor for converting user units to counts

'******************************
'***VR 141 to 160 for Axis 2***
'******************************
 enc_cnt_ax2 = 141 ' axis 2 encoder counts per rotation
 dia_ax2 = 142 ' axis 2 diameter in mm
 gb_ax2 = 143 ' axis 4 Gear Ratio ( assumption isGB > 1)
 speed_ax2 = 144 ' axis 2 speed
 accel_ax2 = 145 ' axis 2 accel
 decel_ax2 = 146 ' axis 2 decel
 creep_ax2 = 147 ' axis 2 homing slow speed
 fdecel_ax2 = 148 ' axis 2 fast deceleration rate
 jspeed_ax2 = 149 ' axis 2 jog speed
 dir_2 = 150 ' axis 2 encoder direction inversion 1= yes, 0 = no
 dat_mode_2 = 151 ' axis 2 datuming/homing mode
 dat_off_2 = 152 ' axis 2 datuming/homing offset
 fact2 = 153 ' multiplying factor for converting user units to counts


'******************************
 axis_select = 281'231 ' select the axis for jogging mode
 e_error_axis = 232 ' error axis number, set on motion error
 plc_cycle_rem = 233 ' amount of PLC time remaining
 m_fact = 234 ' master factor for all units to be same

'******************************
' Internal use VRs and flags
'******************************
 master_state = 300 ' machine state used by main program
' machine state values:
' 0: Disabled state
' 1: Enabled State, set when enabled but not running
' 2: Homing State
' 3: Manual Mode State
' 4: Running Mode State
' 5: Error Mode State

 home_stat_ax0 = 301 ' homing status for axis 0
 home_stat_ax1 = 302 ' homing status for axis 1
 home_stat_ax2 = 303 ' homing status for axis 2
 home_stat_ax3 = 304 ' homing status for axis 3


 man_stat_ax0 = 321 ' manual mode status for axis 0
 man_stat_ax1 = 322 ' manual mode status for axis 1
 man_stat_ax2 = 323 ' manual mode status for axis 2
 man_stat_ax3 = 324 ' manual mode status for axis 3

 auto_cmd = 341 ' auto mode command
 auto_stat = 342 ' auto mode status
 home_stat = 343 ' homing mode status
 man_stat = 344 ' manual mode status
 teach_stat = 345 ' teach mode status

 e_axis_stat0 = 351 ' axis 0 axisstatus error code
 e_axis_stat1 = 352 ' axis 1 axisstatus error code
 e_axis_stat2 = 353 ' axis 2 axisstatus error code
 e_axis_stat3 = 354 ' axis 3 axisstatus error code


 e_axis_fe0 = 361 ' axis 0 latched following error
 e_axis_fe1 = 362 ' axis 1 latched following error
 e_axis_fe2 = 363 ' axis 2 latched following error
 e_axis_fe3 = 364 ' axis 3 latched following error

' For BASICERROR Monitoring in any program
 error_code_main = 391 ' BASIC run Error code - MAIN
 error_line_main = 392 ' BASIC run Error line number - MAIN
 error_code_plc = 393 ' BASIC run Error code - PLC
 error_line_plc = 394 ' BASIC run Error line number - PLC
 error_code_vrset = 395 ' BASIC run Error code - VR_SET
 error_line_vrset = 396 ' BASIC run Error line number - VR_SET
 error_code_startup = 397 ' BASIC run Error code - STARTUP
 error_line_startup = 398 ' BASIC run Error line number - STARTUP
 error_code_man = 399 ' BASIC run Error code - MANUAL
 error_line_man = 400 ' BASIC run Error line number - MANUAL
 error_code_autom = 401 ' BASIC run Error code - AUTOM
 error_line_autom = 402 ' BASIC run Error line number - AUTOM
 error_code_dat = 403 ' BASIC run Error code - DATUMING
 error_line_dat = 404 ' BASIC run Error line number - DATUMING
 error_code_tunn = 405 ' BASIC run Error code - TUNNING
 error_line_tunn = 406 ' BASIC run Error line number - TUNNING
 error_code_shuf = 405 ' BASIC run Error code - Shufler
 error_line_shuf = 406 ' BASIC run Error line number - Shufler


' ***********************************
'           Constants
' ***********************************
'Axis numbers

 mc_ax0 = 0 'x axis
 mc_ax1 = 1 'y axis
 mc_ax2 = 2 'z axis
 mc_ax3 = 3
 mc_ax4 = 4 ' master table
 virt5 = 5 ' virtual axis
 virt6= 6 'virtual axis
 virt7 = 7' virtual axis

