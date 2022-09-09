//Command:push constant 0
@0
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop local 0         // initializes sum = 0
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
//Command:label LOOP_START
(LOOP_START)
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
//Command:pop local 0	        // sum = sum + counter
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
//Command:push constant 1
@1
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:sub
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
//Command:pop argument 0      // counter--
//Pop to ARG[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@ARG
A=M
M=D
//END Pop to ARG[0]
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
//Command:if-goto LOOP_START  // If counter != 0, goto LOOP_START
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@LOOP_START
D; JNE
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
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
