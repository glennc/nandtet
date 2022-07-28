//push constant 10
@10
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop local 0
//Pop to LCL[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@LCL
A=M
M=D
//END Pop to LCL[0]
//push constant 21
@21
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push constant 22
@22
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop argument 2
//Pop to ARG[2]
@ARG
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
//END Pop to ARG[2]
//pop argument 1
//Pop to ARG[1]
@ARG
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
//END Pop to ARG[1]
//push constant 36
@36
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop this 6
//Pop to THIS[6]
@THIS
A=M
D=A
@6
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
//END Pop to THIS[6]
//push constant 42
@42
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push constant 45
@45
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop that 5
//Pop to THAT[5]
@THAT
A=M
D=A
@5
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
//END Pop to THAT[5]
//pop that 2
//Pop to THAT[2]
@THAT
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
//END Pop to THAT[2]
//push constant 510
@510
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop temp 6
//Pop to 5[6]
@5
D=A
@6
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
//END Pop to 5[6]
//push local 0
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
//push that 5
//Push THAT[5] to Stack
@THAT
A=M
D=A
@5
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//add
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
//push argument 1
//Push ARG[1] to Stack
@ARG
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
//sub
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
D=M-D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//- completed.
//push this 6
//Push THIS[6] to Stack
@THIS
A=M
D=A
@6
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push this 6
//Push THIS[6] to Stack
@THIS
A=M
D=A
@6
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//add
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
//sub
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
D=M-D
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//- completed.
//push temp 6
//Push 5[6] to Stack
@5
D=A
@6
A=D+A
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//add
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
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
