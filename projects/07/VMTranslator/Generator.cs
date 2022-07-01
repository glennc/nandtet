

public class HackAssemblyGenerator : IDisposable
{
	private Stream _output;
	private StreamWriter _outputWriter;

	public HackAssemblyGenerator(Stream output)
	{
		_output = output;
		_outputWriter = new StreamWriter(output);
	}

	public void Write(VMCommand command)
	{
		_outputWriter.WriteLine("//" + command.Source);
		switch (command.CommandType)
		{
			case VMCommandType.C_ARITHMETIC:
				WriteArithmatic(command);
				break;
			case VMCommandType.C_PUSH:
			case VMCommandType.C_POP:
                WritePushPop(command);
				break;
			default:
				throw new NotImplementedException();
		};
	}


	public void WriteArithmatic(VMCommand command)
	{
		var op = command.Arg1 switch
		{
			"add" => "+",
			"eq" => "=",
			"gt" => ">",
			"lt" => "<",
			"sub" => "-",
			"neg" => "-",
            "and" => "&",
            "or" => "|",
            "not" => "!",
            _ => throw new NotImplementedException("Unknown Arithmatic Arg1.")
		};

		switch (command.Arg1)
		{
			case "add":
			case "sub":
			case "and":
			case "or":
				WriteArithmaticOperation(command, op);
				break;
			case "not":
			case "neg":
				WriteSingleOperand(command, op);
				break;
            case "eq":
				WriteBooleanOperation(command, "JEQ");
				break;
			case "lt":
				WriteBooleanOperation(command, "JLT");
				break;
			case "gt":
				WriteBooleanOperation(command, "JGT");
				break;
			default:
				throw new NotImplementedException("Unknown Arg1 in aritmatic dispatcher");
        }

		_outputWriter.WriteLine($"//{op} completed.");
    }

	private void WriteBooleanOperation(VMCommand command, string jumpString)
	{
		var guid = Guid.NewGuid().ToString().Replace("-","");
		var guid2 = Guid.NewGuid().ToString().Replace("-","");
        WritePPop(_outputWriter);
		_outputWriter.WriteLine("D=M");
		WritePPop(_outputWriter);
		_outputWriter.WriteLine("D=M-D");
		_outputWriter.WriteLine($"@{guid2}");
		_outputWriter.WriteLine($"D;{jumpString}");
		_outputWriter.WriteLine("D=0");
		_outputWriter.WriteLine($"@{guid}");
		_outputWriter.WriteLine("	0;JMP");
		_outputWriter.WriteLine($"({guid2})");
        _outputWriter.WriteLine("	D=-1");
		_outputWriter.WriteLine($"({guid})");

        WritePushDToStack(_outputWriter);

    }

    private void WriteSingleOperand(VMCommand command, string op)
	{
		WritePPop(_outputWriter);
		_outputWriter.WriteLine($"M={op}M");
        _outputWriter.WriteLine("@SP");
        _outputWriter.WriteLine("M=M+1");
    }

	private void WriteArithmaticOperation(VMCommand command, string operation)
	{
		WritePPop(_outputWriter);
		_outputWriter.WriteLine("D=M");
		WritePPop(_outputWriter);
		_outputWriter.WriteLine($"D=M{operation}D");
		WritePushDToStack(_outputWriter);
	}

	public void WritePushPop(VMCommand command)
	{
		if (command.CommandType == VMCommandType.C_PUSH)
		{
			//push value of D register:
			//@SP, A=M, M=D, @SP, M=M+1
			//TODO: This is wrong push segment 5 means push index 5 of segment onto the stack. 
			switch (command.Arg1)
			{
				case "constant":
					_outputWriter.WriteLine($"@{command.Arg2}");
					_outputWriter.WriteLine("D=A");
					WritePushDToStack(_outputWriter);
					break;
				case "local":
					_outputWriter.WriteLine($"@{command.Arg2}");
					_outputWriter.WriteLine("D=A");
					WritePushDToLocal(_outputWriter);
					break;
				case "argument":
					_outputWriter.WriteLine($"@{command.Arg2}");
					_outputWriter.WriteLine("D=A");
					WritePushDToLocal(_outputWriter);
					break;
				default:
					throw new NotImplementedException("Unknown Arg1 in Push");
			}
		}
		else if (command.CommandType == VMCommandType.C_POP)
		{
            switch (command.Arg1)
            {
                case "constant":
					WritePop(_outputWriter);
                    break;
                case "local":
                    
                    break;
                case "argument":
                    
                    break;
                default:
                    throw new NotImplementedException("Unknown Arg1 in Pop");
            }
        }
	}

    private static void WritePushDToLocal(StreamWriter writer)
    {
		writer.WriteLine("//Push D to Local");
        writer.WriteLine("@LCL");
        writer.WriteLine("A=M");
        writer.WriteLine("M=D");
        writer.WriteLine("@LCL");
        writer.WriteLine("M=M+1");
    }

    private static void WritePushDToStack(StreamWriter writer)
	{
        writer.WriteLine("//Push D to Stack");
        writer.WriteLine("@SP");
        writer.WriteLine("A=M");
        writer.WriteLine("M=D");
        writer.WriteLine("@SP");
        writer.WriteLine("M=M+1");
    }

	private static void WritePop(StreamWriter writer)
	{
        writer.WriteLine("//Pop to D");
        writer.WriteLine("@SP");
        writer.WriteLine("M=M-1");
		writer.WriteLine("A=M");
        writer.WriteLine("D=M");
    }

    private static void WritePPop(StreamWriter writer)
    {
        writer.WriteLine("//Partial Pop, point to memory address but don't move to register or operate on.");

        writer.WriteLine("@SP");
        writer.WriteLine("M=M-1");
        writer.WriteLine("A=M");
    }

    public void Dispose()
	{
		_outputWriter.Dispose();
	}

	internal void Done()
	{
        _outputWriter.WriteLine("(INFINITE_LOOP)");
        _outputWriter.WriteLine("	@INFINITE_LOOP");
        _outputWriter.WriteLine("	0; JMP");
		_outputWriter.Flush();
    }
}