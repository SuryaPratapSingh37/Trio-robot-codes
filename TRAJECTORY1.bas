SERVO AXIS(0)=ON
UNITS AXIS(0)=131072
SERVO AXIS(1)=ON
UNITS AXIS(1)=131072
SERVO AXIS(2)=ON
UNITS AXIS(2)=131072

x0=63/360
x1=45/360
x2=45/360

speed0=4'enter the speed in rpm
accel0=2'enter the accel
decel0=accel0

speed1=4'enter the speed in rpm
accel1=2'enter the accel
decel1=accel1

speed2=4'enter the speed in rpm
accel2=2'enter the accel
decel2=accel2

'1st movement

deg0=20'-30'enter the degrees(positive=clockwise) for axis 0 to which u want to move
deg1=60'enter the degrees(positive=anticlockwise) for axis 1 to which u want to move
deg2=40'enter the degrees(positive=anticlockwise) for axis 1 to which u want to move

y0=deg0*x0
y1=deg1*x1
y2=deg2*x2

BASE(0)

SPEED=speed0
ACCEL=accel0
DECEL=decel0

MOVE(y0) 'enter in degrees
WAIT IDLE AXIS(0)


BASE(1)

SPEED=speed1
ACCEL=accel1
DECEL=decel1

MOVE(y1) 'enter in degrees
WAIT IDLE AXIS(1)


BASE(2)

SPEED=speed2
ACCEL=accel2
DECEL=decel2

MOVE(y2) 'enter in degrees
WAIT IDLE AXIS(2)

PRINT("1st movement done")
'2nd movement

deg0=10'enter the degrees for axis 0 to which u want to move
deg1=-20'enter the degrees for axis 1 to which u want to move
deg2=-80'enter the degrees for axis 1 to which u want to move

y0=deg0*x0
y1=deg1*x1
y2=deg2*x2

BASE(0)

SPEED=speed0
ACCEL=accel0
DECEL=decel0

MOVE(y0) 'enter in degrees
WAIT IDLE AXIS(0)


BASE(1)

SPEED=speed1
ACCEL=accel1
DECEL=decel1

MOVE(y1) 'enter in degrees
WAIT IDLE AXIS(1)


BASE(2)

SPEED=speed2
ACCEL=accel2
DECEL=decel2

MOVE(y2) 'enter in degrees
WAIT IDLE AXIS(2)

PRINT("2nd movement done")
'3rd movement

deg0=-30'enter the degrees for axis 0 to which u want to move
deg1=-20'enter the degrees for axis 1 to which u want to move
deg2=40'enter the degrees for axis 1 to which u want to move

y0=deg0*x0
y1=deg1*x1
y2=deg2*x2

BASE(0)

SPEED=speed0
ACCEL=accel0
DECEL=decel0

MOVE(y0) 'enter in degrees
WAIT IDLE AXIS(0)


BASE(1)

SPEED=speed1
ACCEL=accel1
DECEL=decel1

MOVE(y1) 'enter in degrees
WAIT IDLE AXIS(1)


BASE(2)

SPEED=speed2
ACCEL=accel2
DECEL=decel2

MOVE(y2) 'enter in degrees
WAIT IDLE AXIS(2)

PRINT("3rd movement done")
