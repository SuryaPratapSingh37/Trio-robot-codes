
INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine ' When a program error occurs, print the error to the terminal and
'stop all the motion only IN CASE the error routine has NOT been executed
'  due TO a normal stopping of the program



' machine specific Variables
VR(network_drive) = ON 'drive type OFF = analog, ON = network or pulse/direction servo

'VRs specific to axis
' front lable axis
' ******* Setup parameter for axis 0 ***********************
VR(enc_cnt_ax0) = 2^17' encoder counts per rotation
VR(dia_ax0) = 1 '(60 teath * 8 pitch) 'pitch/diameter/circumference in mm
VR(gb_ax0) = 45'1 '40 '6 'Gear Ratio
VR(speed_ax0) = 2' speed in user units/sec
VR(accel_ax0) = 0.5 ' accel in user units/sec^2
VR(decel_ax0) = 0.5 ' decel in user units/sec^2
VR(creep_ax0) = 10'5 ' homing slow speed user units/sec
VR(fdecel_ax0) = 1200'1500'800 ' fast deceleration rate
VR(jspeed_ax0) = 5' jog speed user units/sec
VR(dir_0) = 0'1 'encoder direction inversion? 1= REQUIRED, 0 = NOT REQUIRED
IF VR(dia_ax0) <> 0 THEN
    VR(fact0)=VR(enc_cnt_ax0)

ENDIF


' ******* Setup parameter for axis 1 ***********************
VR(enc_cnt_ax1) = 2^17 ' encoder counts per rotation
VR(dia_ax1) = 14 '(60 teath * 8 pitch) 'pitch/diameter/circumference in mm
VR(gb_ax1) = 45 '40 '6 'Gear Ratio
VR(speed_ax1) = 2' speed in user units/sec
VR(accel_ax1) = 0.5 ' accel in user units/sec^2
VR(decel_ax1) = 0.5 ' decel in user units/sec^2
VR(creep_ax1) = 10'5 ' homing slow speed user units/sec
VR(fdecel_ax1) = 1200'1500'800 ' fast deceleration rate
VR(jspeed_ax1) = 5' jog speed user units/sec
VR(dir_1) = 0'1 'encoder direction inversion? 1= REQUIRED, 0 = NOT REQUIRED
IF VR(dia_ax1) <> 0 THEN
    VR(fact1)=VR(enc_cnt_ax1)
ENDIF

'' ******* Setup parameter for axis 2 ***********************
VR(enc_cnt_ax2) = 2^17 '3600*4 ' encoder counts per rotation
VR(dia_ax2) = 14 ' diameter/circumference in mm
VR(gb_ax2) = 65 '1' Gear Ratio
VR(speed_ax2) = 2'10 ' speed in user units/sec
VR(accel_ax2) = 0.5 ' accel in user units/sec^2
VR(decel_ax2) = 0.5 ' decel in user units/sec^2
VR(creep_ax2) = 10 ' homing slow speed user units/sec
VR(fdecel_ax2) = 9999.0 ' fast deceleration rate
VR(jspeed_ax2) = 0' jog speed user units/sec
VR(dat_off_2)=0
VR(dir_2) = 0'1 'encoder direction inversion? 1= REQUIRED, 0 = NOT REQUIRED
IF VR(dia_ax2) <> 0 THEN
    VR(fact2)=VR(enc_cnt_ax2)
ENDIF

' ******* Setup parameter for axis 5 ***********************
VR(speed_ax5) = 5000 ' speed in user units/sec
VR(accel_ax5) = 999999.0 ' accel in user units/sec^2
VR(decel_ax5) = 99999999.0 ' decel in user units/sec^2

' ******* Setup parameter for axis 6 ***********************
VR(speed_ax6) = 5000 ' speed in user units/sec
VR(accel_ax6) = 999999.0 ' accel in user units/sec^2
VR(decel_ax6) = 99999999.0 ' decel in user units/sec^2

STOP


error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_vrset) = RUN_ERROR
    VR(error_line_vrset) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm6,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];"in VR_SET"
ENDIF

STOP
