@256
D=A
@SP
M=D
@435b7224
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
(435b7224)
//Command:function Main.fibonacci 0
(Main.fibonacci)
D=0
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
//Command:lt                     // checks if n<2
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
@f107d4be7c1e465ba96ef728275f422e
D;JLT
D=0
@d89720b2f9ff43e58cf05b91de8fa915
	0;JMP
(f107d4be7c1e465ba96ef728275f422e)
	D=-1
(d89720b2f9ff43e58cf05b91de8fa915)
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//< completed.
//Command:if-goto IF_TRUE
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@IF_TRUE
D; JNE
//Command:goto IF_FALSE
@IF_FALSE
0; JMP
//Command:label IF_TRUE          // if n<2, return n
(IF_TRUE)
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
//Command:label IF_FALSE         // if n>=2, returns fib(n-2)+fib(n-1)
(IF_FALSE)
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
//Command:call Main.fibonacci 1  // computes fib(n-2)
@5494be16
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
@Main.fibonacci
0;JMP
(5494be16)
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
//Command:call Main.fibonacci 1  // computes fib(n-1)
@3a2c754
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
@Main.fibonacci
0;JMP
(3a2c754)
//Command:add                    // returns fib(n-1) + fib(n-2)
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
//Command:function Sys.init 0
(Sys.init)
D=0
//Command:push constant 4
@4
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:call Main.fibonacci 1   // computes the 4'th fibonacci element
@4d4da109
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
@Main.fibonacci
0;JMP
(4d4da109)
//Command:label WHILE
(WHILE)
//Command:goto WHILE              // loops infinitely
@WHILE
0; JMP
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
