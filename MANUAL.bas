
' WRITE UR Manual MODE program HERE

INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine

WHILE VR(manual) = ON

    selected_axis = VR(axis_select)

    jspdax0 = (VR(jspeed_ax0)) ' jog for puller in mm/sec

'    jspdax1 = (VR(jspeed_ax1))' jog for puller in mm/sec
'    jspdax2 = (VR(jspeed_ax2)) ' jog for sealer strokes /sec

    'set the speed
    SPEED AXIS(mc_ax0) = jspdax0
    SPEED AXIS(mc_ax1) = jspdax0
    SPEED AXIS(mc_ax2) = jspdax0

    ACCEL AXIS(mc_ax0) = SPEED AXIS(mc_ax0) * 10
    ACCEL AXIS(mc_ax1) = SPEED AXIS(mc_ax1) * 10
    ACCEL AXIS(mc_ax2) = SPEED AXIS(mc_ax2) * 10

    DECEL AXIS(mc_ax0) = ACCEL AXIS(mc_ax0)
    DECEL AXIS(mc_ax1) = ACCEL AXIS(mc_ax1)
    DECEL AXIS(mc_ax2) = ACCEL AXIS(mc_ax2)

    BASE(selected_axis)
    ' stop axis
    IF VR(jog_fwd)=0 AND VR(jog_rev)=0 THEN
        CANCEL
        WAIT IDLE
    ENDIF

    ' jog forward
    IF VR(jog_fwd)=1 AND (MTYPE =0) THEN
        FORWARD
        WA(10)
    ENDIF
    ' jog reverse
    IF VR(jog_rev)=1 AND (MTYPE =0) THEN
        REVERSE
        WA(10)
    ENDIF

WEND

VR(man_stat)=1

STOP

error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_man) = RUN_ERROR
    VR(error_line_man) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm4,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];" in MANUAL"
ENDIF

STOP




