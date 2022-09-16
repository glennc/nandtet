@256
D=A
@SP
M=D
@349234d
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
(349234d)
//Command:function Class1.set 0
(Class1.set)
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
//Command:pop static 0
//Pop to Class1.0[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@Class1.0
M=D
//END Pop to Class1.0[0]
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
//Command:pop static 1
//Pop to Class1.1[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@Class1.1
M=D
//END Pop to Class1.1[0]
//Command:push constant 0
@0
D=A
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
//Command:function Class1.get 0
(Class1.get)
D=0
//Command:push static 0
//Push Class1.0[0] to Stack
@Class1.0
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push static 1
//Push Class1.1[0] to Stack
@Class1.1
D=M
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
//Command:function Class2.set 0
(Class2.set)
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
//Command:pop static 0
//Pop to Class2.0[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@Class2.0
M=D
//END Pop to Class2.0[0]
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
//Command:pop static 1
//Pop to Class2.1[0]
//Partial Pop, point to memory address but don't move to register or operate on.
@SP
M=M-1
A=M
//END Partial Pop
D=M
@Class2.1
M=D
//END Pop to Class2.1[0]
//Command:push constant 0
@0
D=A
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
//Command:function Class2.get 0
(Class2.get)
D=0
//Command:push static 0
//Push Class2.0[0] to Stack
@Class2.0
D=M
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push static 1
//Push Class2.1[0] to Stack
@Class2.1
D=M
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
//Command:push constant 6
@6
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push constant 8
@8
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:call Class1.set 2
@55dda041
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
@7
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class1.set
0;JMP
(55dda041)
//Command:pop temp 0 // Dumps the return value
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
//Command:push constant 23
@23
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:push constant 15
@15
D=A
//Push D to SP
@SP
A=M
M=D
@SP
M=M+1
//Command:call Class2.set 2
@d12761
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
@7
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class2.set
0;JMP
(d12761)
//Command:pop temp 0 // Dumps the return value
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
//Command:call Class1.get 0
@5dee7056
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
@Class1.get
0;JMP
(5dee7056)
//Command:call Class2.get 0
@68515e9a
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
@Class2.get
0;JMP
(68515e9a)
//Command:label WHILE
(WHILE)
//Command:goto WHILE
@WHILE
0; JMP
(INFINITE_LOOP)
	@INFINITE_LOOP
	0; JMP
