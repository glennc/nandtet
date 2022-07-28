//push constant 111
@111
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push constant 333
@333
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push constant 888
@888
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop static 8
//Pop to StaticTest.8[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@StaticTest.8
M=D
//END Pop to StaticTest.8[0]
//pop static 3
//Pop to StaticTest.3[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@StaticTest.3
M=D
//END Pop to StaticTest.3[0]
//pop static 1
//Pop to StaticTest.1[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@StaticTest.1
M=D
//END Pop to StaticTest.1[0]
//push static 3
//Push StaticTest.3[0] to Stack
@StaticTest.3
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//push static 1
//Push StaticTest.1[0] to Stack
@StaticTest.1
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
//push static 8
//Push StaticTest.8[0] to Stack
@StaticTest.8
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
