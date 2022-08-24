//push constant 0
@0
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop local 0         // initializes sum = 0
//Pop to LCL[]
@LCL
A=M
D=A
@
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
//END Pop to LCL[]
//label LOOP_START
(LOOP_START)//push argument 0
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
//pop local 0	        // sum = sum + counter
//Pop to LCL[]
@LCL
A=M
D=A
@
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
//END Pop to LCL[]
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
//push constant 1
@1
D=A
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
//pop argument 0      // counter--
//Pop to ARG[]
@ARG
A=M
D=A
@
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
//END Pop to ARG[]
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
//if-goto LOOP_START  // If counter != 0, goto LOOP_START
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
@LOOP_STARTM; JEQ//push local 0
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
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
