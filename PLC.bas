' PLC Logic operations
' Examples of various logical operations
' Repeat loop is used to "scan" the inputs

INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine

'HMI Port setting
ADDRESS=1
SETCOM(9600,8,1,2,2,4)

'====== Ethernet Communication 16 bit instruction written to avoid noise/delay on HUB
ETHERNET(1,-1,14,0,2,0)
ETHERNET(1,-1,14,0,1,3)
ETHERNET(1,-1,14,0,6,0)


VR(cycle_st) = 0
FOR i=52 TO 56 ' reset operation command flags
    VR(i)=0
NEXT i
'VR(enable) = ON ' default machine enable is ON comment only if operated by HMI scree

REPEAT


    GOSUB machine_control
    GOSUB hmi_control
    GOSUB alarm_control


UNTIL FALSE ' repeats forever


machine_control:



RETURN


alarm_control:

OP(o_error,OFF) 'kept default off turn ON for alarm

RETURN

hmi_control:

'Program selecetion and i/p indication--------------------------------
VR(x_pos_hmi) = DPOS AXIS(0)*10
VR(y_pos_hmi) = DPOS AXIS(1)*10
VR(z_pos_hmi) = DPOS AXIS(2)*10


RETURN

error_routine:
IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_plc) = RUN_ERROR
    VR(error_line_plc) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm2,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];" in PLC"
ENDIF

STOP


