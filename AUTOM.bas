' automatic program
INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine

REPEAT

UNTIL VR(auto) = 0


GOSUB stop_motion
VR(auto_stat) = 1
STOP

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Stop all motion from MTYPE and NTYPE
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
stop_motion:
FOR axis_no=0 TO LAST_AXIS
    'Clear buffered moves

    BASE(axis_no)
    CANCEL(2)
    WA(2)
    'Clear any ADDAX
    ADDAX(-1)
NEXT axis_no
RAPIDSTOP(2)
WAIT IDLE

RETURN

error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_autom) = RUN_ERROR
    VR(error_line_autom) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm3,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];" in AUTOM"
ENDIF

STOP




