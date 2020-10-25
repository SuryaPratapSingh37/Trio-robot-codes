'Start Standard Section
INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine


' Axis Parameters
LIMIT_BUFFERED=60

BASE(0)
'ATYPE=44
UNITS = VR(fact0)
'gains
D_GAIN=0.0
D_ZONE_MAX=0
D_ZONE_MIN=0
I_GAIN=0
OV_GAIN=0
P_GAIN=0.1 '0.4
VFF_GAIN=0 '40
'velocity profile
ACCEL=VR(accel_ax0)
CREEP=VR(creep_ax0)
DECEL=VR(decel_ax0)
JOGSPEED=VR(jspeed_ax0)
SPEED=VR(speed_ax0)
SRAMP=0
FASTDEC=VR(fdecel_ax0)
FHSPEED=0
'limits
AXIS_FS_LIMIT=400000000000
AXIS_RS_LIMIT=-400000000000
DATUM_IN=-1
FE_LIMIT=20
FE_RANGE=10
'FHOLD_IN = feed_hold_in'-1
FS_LIMIT=400000000000 '600
REV_IN = -1
FWD_IN = -1

REP_DIST=200000000
REP_OPTION=0
RS_LIMIT=-400000000000 '-600
' axis output
OUTLIMIT=2047
SERVO=1
AXIS_ENABLE = 1
'jogging
FAST_JOG=-1
FWD_JOG=-1
REV_JOG=-1
' control
AXIS_MODE=0
BACKLASH_DIST=0
CLUTCH_RATE=1000000
'ERRORMASK=268
'default error mask bits = 2, 3 & 8
'error mask lgoc added for hard limit and soft limit active
'ERRORMASK = (4 + 8 + 256 + 16+32+512+1024)
FE_LIMIT_MODE=0
'INVERT_STEP=0
'registration
CLOSE_WIN=0
OPEN_WIN=0
REGIST_DELAY=0
REG_INPUTS=0

' direction inversion
IF VR(dir_0) = 0 THEN
    ENCODER_RATIO(1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(1,1)
    ELSE
        DAC_SCALE=1
    ENDIF
ELSE
    ENCODER_RATIO(-1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(-1,1)
    ELSE
        DAC_SCALE=-1
    ENDIF
ENDIF

'================
BASE(1)
'ATYPE=44
UNITS = VR(fact1)
'gains
D_GAIN=0.0
D_ZONE_MAX=0
D_ZONE_MIN=0
I_GAIN=0
OV_GAIN=0
P_GAIN=0.1 '0.4
VFF_GAIN=0 '40
'velocity profile
ACCEL=VR(accel_ax1)
CREEP=VR(creep_ax1)
DECEL=VR(decel_ax1)
JOGSPEED=VR(jspeed_ax1)
SPEED=VR(speed_ax1)
SRAMP=0
FASTDEC=VR(fdecel_ax1)
FHSPEED=0
'limits
AXIS_FS_LIMIT=400000000000
AXIS_RS_LIMIT=-400000000000
DATUM_IN=-1
FE_LIMIT=1000000000
FE_RANGE=500000000.0000
'FHOLD_IN = feed_hold_in'-1
FS_LIMIT=400000000000 '400
REV_IN = -1
FWD_IN = -1

REP_DIST=200000000
REP_OPTION=0
RS_LIMIT=-400000000000 '-400
' axis output
OUTLIMIT=2047
SERVO=1
AXIS_ENABLE = 1
'jogging
FAST_JOG=-1
FWD_JOG=-1
REV_JOG=-1
' control
AXIS_MODE=0
BACKLASH_DIST=0
CLUTCH_RATE=1000000
'default error mask bits = 2, 3 & 8
'error mask lgoc added for hard limit and soft limit active
'ERRORMASK = (4 + 8 + 256 + 16+32+512+1024)
FE_LIMIT_MODE=0
'INVERT_STEP=0
'registration
CLOSE_WIN=0
OPEN_WIN=0
REGIST_DELAY=0
REG_INPUTS=1

' direction inversion
IF VR(dir_1) = 0 THEN
    ENCODER_RATIO(1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(1,1)
    ELSE
        DAC_SCALE=1
    ENDIF
ELSE
    ENCODER_RATIO(-1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(-1,1)
    ELSE
        DAC_SCALE=-1
    ENDIF
ENDIF

'================
BASE(2)
'ATYPE=44
UNITS = VR(fact2)
'gains
D_GAIN=0.0
D_ZONE_MAX=0
D_ZONE_MIN=0
I_GAIN=0
OV_GAIN=0
P_GAIN=0.1 '0.4
VFF_GAIN=0 '40
'velocity profile
ACCEL=VR(accel_ax2)
CREEP=VR(creep_ax2)
DECEL=VR(decel_ax2)
JOGSPEED=VR(jspeed_ax2)
SPEED=VR(speed_ax2)
SRAMP=0
FASTDEC=VR(fdecel_ax2)
FHSPEED=0
'limits
AXIS_FS_LIMIT=400000000000
AXIS_RS_LIMIT=-400000000000
DATUM_IN=-1
FE_LIMIT=1000000000
FE_RANGE=500000000.0000
FHOLD_IN = -1'feed_hold_in'-1
FS_LIMIT=400000000000 '400
REV_IN = -1
FWD_IN = -1

REP_DIST=200000000
REP_OPTION=0
RS_LIMIT=-400000000000 '-400
' axis output
OUTLIMIT=2047
SERVO=1
AXIS_ENABLE = 1
'jogging
FAST_JOG=-1
FWD_JOG=-1
REV_JOG=-1
' control
AXIS_MODE=0
BACKLASH_DIST=0
CLUTCH_RATE=1000000
'default error mask bits = 2, 3 & 8
'error mask lgoc added for hard limit and soft limit active
'ERRORMASK = (4 + 8 + 256 + 16+32+512+1024)
FE_LIMIT_MODE=0
'INVERT_STEP=0
'registration
CLOSE_WIN=0
OPEN_WIN=0
REGIST_DELAY=0
REG_INPUTS=1

' direction inversion
' direction inversion
IF VR(dir_2) = 0 THEN
    ENCODER_RATIO(1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(1,1)
    ELSE
        DAC_SCALE=1
    ENDIF
ELSE
    ENCODER_RATIO(-1,1)
    IF VR(network_drive) = ON THEN
        STEP_RATIO(-1,1)
    ELSE
        DAC_SCALE=-1
    ENDIF
ENDIF



'Stop Standard Section

STOP

error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_startup) = RUN_ERROR
    VR(error_line_startup) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm7,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];"in STARTUP"
ENDIF

STOP
