'==========================================================
' Project template for Motion Coordinator
' Authors: DJ + GD
' Version: 3.01
' Date:    07/05/2012
' Target platform: MC4xx
'==========================================================
' Project contains example programs for initialisation, homing, manual jog,
' machine run mode and I/O controls
' Program MAIN to run on power up on process 5
'==========================================================
INCLUDE "INITIALISE"
ON BASICERROR GOTO error_routine


'==========================================================
' Controller Firmware version Check
'==========================================================


'==========================================================
' initialize ETHERCAT
'==========================================================
''delay IN telegram
ETHERCAT($91, -1, 1000150)'$91? AND ETHERCAT PORT SLOT NUMBER=-1 AND
'no. of times master attempts TO restart ETHERNET auto-negotiation=1000150; will return 1 if true else 0 if error

''GET the ecat status so returns values between 0 and 3 depending on the state
ETHERCAT($22,0,ethercat_stat) 'ethercat_stat=59 in INITIALISE
' if ethercat_stat=3 then function is to check number of slaves
'
''INITIALISE ecat
IF VR(ethercat_stat) <> 3 AND CONTROL <> 400 THEN' CONTROL returns the ID of the motion coordnator and 400=simulator
    WA(5000) 'delay for 5000 milliseconds for drive to start
    ETHERCAT(0,0) 'initialise ethercat
    WA(1000)
ENDIF
'
''find number of AXIS
VR(no_of_ecat_axes) = 0 'no_of_ecat_axes=60 in INITIALISE
WHILE ATYPE = 65 ' ATYPE =65 MEANS it gives ethercat position, by default set to match the hardware?
    VR(no_of_ecat_axes) = VR(no_of_ecat_axes) +1
    BASE(VR(no_of_ecat_axes))
WEND
PRINT "AXIS INITIALISED = ";VR(no_of_ecat_axes)[0]


'==========================================================
' Start the background "plc" example
'==========================================================
RUN "PLC",2 'Run the PLC program on process 2?

'==========================================================
' 0. Machine disabled State:  Program starts here on power up
'==========================================================
VR(master_state)=0 ' set state to machine disabled; master_state=300 set in INITIALISE
REPEAT 'repeat the commands from line 56 to 312 UNTIL COMMAND LIINE 313
    IF VR(master_state)=0 THEN
        'Stop all programs from running
        STOP "DATUMING"
        STOP "MANUAL"
        STOP "AUTOM"


        RAPIDSTOP(2) 'Stop all motion

        WAIT IDLE AXIS(0) 'Wait for motion to stop
        WAIT IDLE AXIS(1)
        WAIT IDLE AXIS(2)
        WAIT IDLE AXIS(3)


        WDOG=OFF ' disable drives

        ' set all status flags to 0
        FOR i=301 TO 364' 301 TO 364 ARE VALUES ASSIGNED TO SOME VARIABLES  IN INITIALISE
            VR(i)=0
        NEXT i
'
        FOR error_axis_no = mc_ax0 TO mc_ax2
            IF ATYPE AXIS(error_axis_no) = 65 AND AXISSTATUS AXIS(error_axis_no) <> 0 THEN

                ETHERCAT($64,error_axis_no,1,50)
                WA(5)
                PRINT#5, "Error was in axis ";error_axis_no[0]
            ENDIF

        NEXT error_axis_no


        ' reset axis error flags
        IF MOTION_ERROR<>0 THEN
            DATUM(0)
        ENDIF
'
        BASE(mc_ax0)
        IF SYSTEM_ERROR <> 0 AND AXISSTATUS.2 = ON THEN
            ETHERCAT(1,0)
            WA(1000)
            ETHERCAT(1,0)
            WA(1000)
            ETHERCAT(0,0)
            WA(2000)
        ENDIF

        IF SYSTEM_ERROR <> 0 THEN UNIT_CLEAR
        WA(100) ' wait for flags and errors to clear


        PRINT #5,"Machine Idle"
        home_done = 0
        VR(home_stat) = 0
        VR(auto_stat) = 0
        VR(auto_cmd) = 0
        VR(auto)=0
        VR(manual)=0
        VR(home_start)= 0
        'wait for machine to be turned ON
        WAIT UNTIL ( READ_OP(o_error)=OFF ) OR MOTION_ERROR<>0

        IF MOTION_ERROR<>0 THEN
            PRINT #5,"Motion Error Detected ";VR(master_state)[0]
            VR(master_state)=5
        ELSE
            RUN "VR_SET",0 'initialise VR table
'         WAIT UNTIL PROC_STATUS PROC(0)<>0
            WA(2)
            WAIT UNTIL PROC_STATUS PROC(0)=0
            WA(10)
            RUN "STARTUP",0 'apply initial settings
'       WAIT UNTIL PROC_STATUS PROC(0)<>0
            WA(2)
            WAIT UNTIL PROC_STATUS PROC(0)=0
            m_active_flag=0
            VR(master_state)=1
            ' WA(1000)
        ENDIF
        ' end of machine_disabled state

'==========================================================
' 1. Machine Active State:  Drives enabled but no motion
'==========================================================
    ELSEIF VR(master_state)=1 THEN

        IF m_active_flag=0 THEN
            WDOG=ON 'enables the motors

            m_active_flag=1
            PRINT #5,"Machine Active"
        ENDIF

        IF MOTION_ERROR<>0 THEN
            PRINT #5,"Motion Error Detected ";VR(master_state)[0]
            VR(master_state)=5
        ELSE
            IF READ_OP(o_error) = ON THEN
                VR(master_state)=0
            ELSEIF VR(home_start)=ON THEN
                VR(master_state)=2
            ELSEIF VR(manual)=ON THEN
                VR(master_state)=3
            ELSEIF VR(auto)=ON AND VR(home_stat) = 1 THEN
                VR(master_state)=4
            ENDIF
        ENDIF
        ' end of machine_active state

'==========================================================
' 2. Machine Datuming State:  Homing program is running
'==========================================================
    ELSEIF VR(master_state)=2 THEN

        IF PROC_STATUS PROC(0)=0 THEN
            VR(home_stat)=0
            home_donew = 0
            RUN "DATUMING",3 'move the motors to the home switch
            PRINT #5,"Starting Homing Mode"
            WA(20)
        ENDIF
        REPEAT
            home_status = VR(home_stat)
        UNTIL home_status<>0 OR MOTION_ERROR OR READ_OP(o_error) = ON
        WA(1000)
        IF MOTION_ERROR THEN
            PRINT #5,"Motion Error Detected ";VR(master_state)[0]
            VR(master_state)=5
        ELSEIF READ_OP(o_error) = ON THEN
            PRINT #5,"Disable Machine"
            VR(master_state)=0 ' go to disabled state
        ELSEIF home_status=1 THEN
            OP(home_ok,ON) 'set homing indicator
            home_donew = 1
            PRINT #5,"Homing Complete"
            STOP "DATUMING"
            VR(master_state)=1 ' return to active state
        ELSE
            ' routines for handling failed homing reports
            PRINT #5,"Unidentified Homing Status"
            STOP "DATUMING"
            VR(master_state)=1 ' return to active state
        ENDIF
        ' end of machine_homing state

'==========================================================
' 3. Manual Mode State: Manual Mode program is running
'==========================================================
    ELSEIF VR(master_state)=3 THEN

        IF PROC_STATUS PROC(3)=0 THEN
            VR(man_stat) =0
            VR(home_stat) =0
            RUN "MANUAL",3 'move the motors as commanded by operator
            PRINT #5,"Starting Manual Mode"
            WA(20)
        ENDIF
        REPEAT
            manual_stat = VR(man_stat)
        UNTIL manual_stat<>0 OR MOTION_ERROR OR READ_OP(o_error) = ON
        IF MOTION_ERROR THEN
            PRINT #5,"Motion Error Detected ";VR(master_state)[0]
            VR(master_state)=5
        ELSEIF READ_OP(o_error) = ON THEN
            PRINT #5,"Disable Machine"
            VR(master_state)=0 ' go to disabled state
        ELSEIF manual_stat=1 THEN
            PRINT #5,"Leaving Manual Mode"
            STOP "MANUAL"
            VR(master_state)=1 ' return to active state
        ELSE
            ' routines for handling other manual mode reports
            PRINT #5,"Unidentified Manual Mode Status"
            STOP "MANUAL"
            VR(master_state)=1 ' return to active state
        ENDIF
        ' end of manual mode state

'==========================================================
' 4. Automatic Mode State: Machine is running
'==========================================================
    ELSEIF VR(master_state)=4 THEN

        IF PROC_STATUS PROC(3)=0 THEN
            VR(auto_cmd)=0
            VR(auto_stat)=0
            RUN "AUTOM",3 'move the motors as commanded by operator
            PRINT #5,"Starting Machine Auto cycle"
            WA(20)
            VR(auto_on)=1
        ENDIF
        WAIT UNTIL VR(auto_stat)<>0 OR MOTION_ERROR OR READ_OP(o_error) = ON
        IF MOTION_ERROR THEN
            PRINT #5,"Motion Error Detected ";VR(master_state)[0]
            VR(master_state)=5
        ELSEIF READ_OP(o_error) = ON THEN
            PRINT #5,"Disable Machine"
            VR(master_state)=0 ' go to disabled state
        ELSEIF VR(auto_stat)=1 THEN
            PRINT #5,"Leaving Auto Mode"
            STOP "AUTOM"
            VR(master_state)=1 ' return to active state
        ELSE
            ' routines for handling other auto mode reports
            PRINT #5,"Unidentified Auto Mode Status"
            STOP "AUTOM"
            VR(master_state)=1 ' return to active state
        ENDIF
        ' end of machine auto state
        VR(home_stat) = 0
        VR(auto_on)=0

'==========================================================
' 5. Error Mode State: Machine error has occured
'==========================================================
    ELSEIF VR(master_state)=5 THEN

        STOP "DATUMING"
        STOP "MANUAL"
        STOP "AUTOM"
        'STOP "SHUFFLER"

        PRINT #5,"Error code : ";HEX(AXISSTATUS AXIS(0));
        PRINT #5," : ";HEX(AXISSTATUS AXIS(1))
        PRINT #5," : ";HEX(AXISSTATUS AXIS(2))
        PRINT #5," : ";HEX(AXISSTATUS AXIS(3))
        VR(e_error_axis)=ERROR_AXIS
        VR(e_axis_stat0)=AXISSTATUS AXIS(0)
        VR(e_axis_stat1)=AXISSTATUS AXIS(1)
        VR(e_axis_stat2)=AXISSTATUS AXIS(2)
        VR(e_axis_stat3)=AXISSTATUS AXIS(3)

        VR(e_axis_fe0)=FE_LATCH AXIS(0)
        VR(e_axis_fe1)=FE_LATCH AXIS(1)
        VR(e_axis_fe2)=FE_LATCH AXIS(2)
        VR(e_axis_fe3)=FE_LATCH AXIS(3)

        OP(o_error,ON)
        ' must cycle the enable input to clear error and re-start


        'ENDIF

        DATUM(0) 'clears motion error
        WA(100) ' wait for flags and errors to clear

        WDOG=OFF

        VR(e_axis_stat0)=AXISSTATUS AXIS(0)
        VR(e_axis_stat1)=AXISSTATUS AXIS(1)
        VR(e_axis_stat2)=AXISSTATUS AXIS(2)
        VR(e_axis_stat3)=AXISSTATUS AXIS(3)
        VR(master_state)=0

    ENDIF
UNTIL FALSE

error_routine:

IF RUN_ERROR <>31 THEN ' 31 is normal stop. Hence not an error
    VR(error_code_main) = RUN_ERROR
    VR(error_line_main) = ERROR_LINE
    PRINT#7, "The error ";RUN_ERROR[0];
    OP(alm1,ON)

    PRINT#7, " occurred in line ";ERROR_LINE[0];" in MAIN"
ENDIF

STOP



