//function SimpleFunction.test 2
(SimpleFunction.test)
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
//push local 1
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
//not
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
M=!M
@SP
M=M+1
//! completed.
//push argument 0
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
//return
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
