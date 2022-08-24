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
//pop pointer 1           // that = argument[1]
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
//push constant 0
@0
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop that 0              // first element in the series = 0
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
//push constant 1
@1
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//pop that 1              // second element in the series = 1
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
//push constant 2
@2
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
//pop argument 0          // num_of_elements -= 2 (first 2 elements are set)
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
//label MAIN_LOOP_START
(MAIN_LOOP_START)
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
//if-goto COMPUTE_ELEMENT // if num_of_elements > 0, goto COMPUTE_ELEMENT
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
@COMPUTE_ELEMENT
M; JEQ
//goto END_PROGRAM        // otherwise, goto END_PROGRAM
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
@END_PROGRAM
0; JMP
//label COMPUTE_ELEMENT
(COMPUTE_ELEMENT)
//push that 0
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
//push that 1
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
//pop that 2              // that[2] = that[0] + that[1]
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
//push constant 1
@1
D=A
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
//pop pointer 1           // that += 1
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
//pop argument 0          // num_of_elements--
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
//goto MAIN_LOOP_START
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
@MAIN_LOOP_START
0; JMP
//label END_PROGRAM
(END_PROGRAM)
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
