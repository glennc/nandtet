//push constant 3030
@3030
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop pointer 0
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
//push constant 3040
@3040
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop pointer 1
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
//push constant 32
@32
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop this 2
//Pop to THIS[2]
@THIS
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
//END Pop to THIS[2]
//push constant 46
@46
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop that 6
//Pop to THAT[6]
@THAT
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
//END Pop to THAT[6]
//push pointer 0
//Push THIS[0] to Stack
@THIS
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push pointer 1
//Push THAT[0] to Stack
@THAT
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
//push this 2
//Push THIS[2] to Stack
@THIS
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
//push that 6
//Push THAT[6] to Stack
@THAT
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
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
