//Command:push argument 1
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
//Command:pop pointer 1           // that = argument[1]
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
//Command:push constant 0
@0
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop that 0              // first element in the series = 0
//Pop to THAT[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@THAT
A=M
M=D
//END Pop to THAT[0]
//Command:push constant 1
@1
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:pop that 1              // second element in the series = 1
//Pop to THAT[1]
@THAT
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
//END Pop to THAT[1]
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
//Command:push constant 2
@2
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
//Command:pop argument 0          // num_of_elements -= 2 (first 2 elements are set)
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
//Command:label MAIN_LOOP_START
(MAIN_LOOP_START)
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
//Command:if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@COMPUTE_ELEMENT
D; JNE
//Command:goto END_PROGRAM        // otherwise, goto END_PROGRAM
@END_PROGRAM
0; JMP
//Command:label COMPUTE_ELEMENT
(COMPUTE_ELEMENT)
//Command:push that 0
//Push THAT[0] to Stack
@THAT
A=M
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push that 1
//Push THAT[1] to Stack
@THAT
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
//Command:pop that 2              // that[2] = that[0] + that[1]
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
//Command:push pointer 1
//Push THAT[0] to Stack
@THAT
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
//Command:pop pointer 1           // that += 1
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
//Command:pop argument 0          // num_of_elements--
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
//Command:goto MAIN_LOOP_START
@MAIN_LOOP_START
0; JMP
//Command:label END_PROGRAM
(END_PROGRAM)
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
