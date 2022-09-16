@256
D=A
@SP
M=D
@a126f7e
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@5
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(a126f7e)
//Command:function Sys.init 0
(Sys.init)
D=0
//Command:push constant 4000	// test THIS and THAT context save
@4000
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 0
//Pop to THIS[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THIS
M=D
//END Pop to THIS[0]
//Command:push constant 5000
@5000
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 1
//Pop to THAT[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THAT
M=D
//END Pop to THAT[0]
//Command:call Sys.main 0
@68f352fb
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@5
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.main
0;JMP
(68f352fb)
//Command:pop temp 1
//Pop to 5[1]
@5
D=A
@1
D=D+A
@R15
M=D
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@R15
A=M
M=D
//END Pop to 5[1]
//Command:label LOOP
(LOOP)
//Command:goto LOOP
@LOOP
0; JMP
//Command:function Sys.main 5
(Sys.main)
D=0
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push constant 4001
@4001
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 0
//Pop to THIS[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THIS
M=D
//END Pop to THIS[0]
//Command:push constant 5001
@5001
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 1
//Pop to THAT[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THAT
M=D
//END Pop to THAT[0]
//Command:push constant 200
@200
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop local 1
//Pop to LCL[1]
@LCL
A=M
D=A
@1
D=D+A
@R15
M=D
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@R15
A=M
M=D
//END Pop to LCL[1]
//Command:push constant 40
@40
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop local 2
//Pop to LCL[2]
@LCL
A=M
D=A
@2
D=D+A
@R15
M=D
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@R15
A=M
M=D
//END Pop to LCL[2]
//Command:push constant 6
@6
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop local 3
//Pop to LCL[3]
@LCL
A=M
D=A
@3
D=D+A
@R15
M=D
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@R15
A=M
M=D
//END Pop to LCL[3]
//Command:push constant 123
@123
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:call Sys.add12 1
@236705d8
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
@6
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.add12
0;JMP
(236705d8)
//Command:pop temp 0
//Pop to 5[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@5
M=D
//END Pop to 5[0]
//Command:push local 0
//Push LCL[0] to Stack
@LCL
A=M
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push local 1
//Push LCL[1] to Stack
@LCL
A=M
D=A
@1
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push local 2
//Push LCL[2] to Stack
@LCL
A=M
D=A
@2
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push local 3
//Push LCL[3] to Stack
@LCL
A=M
D=A
@3
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push local 4
//Push LCL[4] to Stack
@LCL
A=M
D=A
@4
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:add
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M+D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//+ completed.
//Command:add
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M+D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//+ completed.
//Command:add
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M+D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//+ completed.
//Command:add
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M+D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//+ completed.
//Command:return
//return
@LCL
D=M
@R13
M=D
@R13
D=M
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R13
A=M-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
//Command:function Sys.add12 0
(Sys.add12)
D=0
//Command:push constant 4002
@4002
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 0
//Pop to THIS[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THIS
M=D
//END Pop to THIS[0]
//Command:push constant 5002
@5002
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop pointer 1
//Pop to THAT[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THAT
M=D
//END Pop to THAT[0]
//Command:push argument 0
//Push ARG[0] to Stack
@ARG
A=M
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push constant 12
@12
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:add
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M+D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//+ completed.
//Command:return
//return
@LCL
D=M
@R13
M=D
@R13
D=M
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R13
A=M-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
