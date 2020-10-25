' Intialise the axis for P Loop tuning

RUN "VR_SET",0 'initialise VR table
WA(10)
WAIT UNTIL PROC_STATUS PROC(0)=0
WA(10)
RUN "STARTUP",0 'apply initial settings
WA(10)
WAIT UNTIL PROC_STATUS PROC(0)=0
WA(10)



stepsize=480*10

  BASE(0)
  DEFPOS(0)
  WAIT UNTIL OFFPOS=0
  REP_DIST=stepsize
  REP_OPTION=1

' set speed to 3000 rpm
  SPEED=2000
  ACCEL=1000
  DECEL=ACCEL
  SERVO=1

  BASE(1)
  DEFPOS(0)
  WAIT UNTIL OFFPOS=0
  REP_DIST=stepsize
  REP_OPTION=1

' set speed to 3000 rpm
  SPEED=2000
  ACCEL=1000
  DECEL=ACCEL
  SERVO=1

  WDOG=ON
  WA(1000)

  WHILE TRUE

    TRIGGER
    IF IN(0)=ON THEN MOVE(stepsize) AXIS(0)
    IF IN(1)=ON THEN MOVE(stepsize) AXIS(1)
    WAIT UNTIL IDLE AXIS(0) AND IDLE AXIS(1)
'    WDOG=OFF
    WA(1000)
'    WDOG=ON
    IF IN(0)=ON THEN MOVE(-stepsize) AXIS(0)
    IF IN(1)=ON THEN MOVE(-stepsize) AXIS(1)
    WAIT UNTIL IDLE AXIS(0) AND IDLE AXIS(1)
'    WDOG=OFF
    WA(1000)
'    WDOG=ON

  WEND


