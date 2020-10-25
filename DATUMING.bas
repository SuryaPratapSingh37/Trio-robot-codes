
INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine


'---------------------------
'homing sequence
'RAPIDSTOP(2)

CANCEL(2) AXIS(0)
CANCEL(2) AXIS(1)
CANCEL(2) AXIS(2)


WAIT IDLE AXIS(0)
WAIT IDLE AXIS(1)
WAIT IDLE AXIS(2)
WA(2000)

'add your homing cycle here


VR(home_stat) = 1 ' homing completed

PRINT #5,"Exiting Datuming"
STOP


error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_dat) = RUN_ERROR
    VR(error_line_dat) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm3,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];" in DATUMMING"
ENDIF

STOP


