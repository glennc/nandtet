

public class HackAssemblyGenerator : IDisposable
{
	private Stream _output;
	private StreamWriter _outputWriter;
	private string _fileName;

	public HackAssemblyGenerator(Stream output, string filename) : this(output)
	{
		_fileName = filename;
	}

	public HackAssemblyGenerator(Stream stream)
	{
		_output = stream;
        _outputWriter = new StreamWriter(stream);
    }
    internal void SetFile(string fileName)
    {
        _fileName = fileName;
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
			case VMCommandType.C_LABEL:
				WriteLabel(command);
				break;
			case VMCommandType.C_GOTO:
				WriteGoto(command);
				break;
			case VMCommandType.C_IF:
				WriteIf(command);
				break;
			case VMCommandType.C_FUNCTION:
			case VMCommandType.C_RETURN:
			case VMCommandType.C_CALL:
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
    private void WriteIf(VMCommand command)
    {
		WritePPop(_outputWriter);
		_outputWriter.WriteLine($"@{command.Arg1}");
		_outputWriter.WriteLine("M; JEQ");
    }

    private void WriteGoto(VMCommand command)
    {
		WritePPop(_outputWriter);
		_outputWriter.WriteLine($"@{command.Arg1}");
		_outputWriter.WriteLine("0; JMP");
    }

    public void WriteLabel(VMCommand command)
    {
        _outputWriter.WriteLine($"({command.Arg1})");
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

	private static bool IsVirtualSegment(string segmentName) =>
		segmentName switch
		{
			"temp" => false,
			"pointer" => false,
			_ => true
		};

	public void WritePushPop(VMCommand command)
	{
		if (command.CommandType == VMCommandType.C_PUSH)
		{
			//push value of D register:
			//@SP, A=M, M=D, @SP, M=M+1
			switch (command.Arg1)
			{
				case "constant":
					_outputWriter.WriteLine($"@{command.Arg2}");
					_outputWriter.WriteLine("D=A");
					WritePushDToStack(_outputWriter);
					break;
				case "local":
					WritePushSegmentToStack(_outputWriter, "LCL", command.Arg2);
					break;
				case "argument":
					WritePushSegmentToStack(_outputWriter, "ARG", command.Arg2);
                    break;
                case "temp":
					WritePushSegmentToStack(_outputWriter, "5", command.Arg2, false);
                    break;
				case "this":
					WritePushSegmentToStack(_outputWriter, "THIS", command.Arg2);
                    break;
				case "that":
                    WritePushSegmentToStack(_outputWriter, "THAT", command.Arg2);
                    break;
                case "pointer":
                    if (command.Arg2 == "0")
                    {
                        WritePushSegmentToStack(_outputWriter, "THIS", "0", false);
                    }
                    else
                    {
                        WritePushSegmentToStack(_outputWriter, "THAT", "0", false);
                    }
					break;
				case "static":
					WritePushSegmentToStack(_outputWriter, $"{_fileName}.{command.Arg2}", "0", false);
                    break;
                default:
					throw new NotImplementedException("Unknown Arg1 in Push");
			}
		}
		else if (command.CommandType == VMCommandType.C_POP)
		{
            switch (command.Arg1)
            {
                case "local":
                    WritePop(_outputWriter, "LCL", command.Arg2);
                    break;
                case "argument":
					WritePop(_outputWriter, "ARG", command.Arg2);
                    break;
				case "temp":
					WritePop(_outputWriter, "5", command.Arg2, false);
					break;
				case "this":
					WritePop(_outputWriter, "THIS", command.Arg2);
					break;
                case "that":
                    WritePop(_outputWriter, "THAT", command.Arg2);
                    break;
				case "pointer":
					if (command.Arg2 == "0")
					{
						WritePop(_outputWriter, "THIS", "0", false);
					}
					else
					{
                        WritePop(_outputWriter, "THAT", "0", false);
                    }
					break;
				case "static":
					WritePop(_outputWriter, $"{_fileName}.{command.Arg2}", "0", false);
					break;
                default:
                    throw new NotImplementedException("Unknown Arg1 in Pop");
            }
        }
	}

	private static void WritePushDToArg(StreamWriter writer) => WritePushD(writer, "ARG");

    private static void WritePushDToLocal(StreamWriter writer) => WritePushD(writer, "LCL");

    private static void WritePushDToStack(StreamWriter writer) => WritePushD(writer, "SP");

    private static void WritePushD(StreamWriter writer, string segment)
    {
        writer.WriteLine($"//Push D to {segment}");
        writer.WriteLine($"@{segment}");
        writer.WriteLine("A=M");
        writer.WriteLine("M=D");
        writer.WriteLine($"@{segment}");
        writer.WriteLine("M=M+1");
    }

	private static void WritePushSegmentToStack(StreamWriter writer, string segment, string index, bool virtualSegment = true)
	{
		writer.WriteLine($"//Push {segment}[{index}] to Stack");
        writer.WriteLine($"@{segment}");

		if (virtualSegment)
		{
			writer.WriteLine("A=M");
		}

        if (index != "0")
        {
			writer.WriteLine("D=A");
			writer.WriteLine($"@{index}");
			writer.WriteLine($"A=D+A");
		}
        writer.WriteLine("D=M");
		WritePushDToStack(writer);
    }

    private static void WritePop(StreamWriter writer, string segment, string index, bool virtualSegment = true)
    {
        writer.WriteLine($"//Pop to {segment}[{index}]");

		if (index != "0")
		{
			writer.WriteLine($"@{segment}");
			if (virtualSegment)
			{
				writer.WriteLine("A=M");
			}
            writer.WriteLine("D=A");

			//Handle index > 0
			writer.WriteLine($"@{index}");
			writer.WriteLine($"D=D+A");

			writer.WriteLine("@R15");
			writer.WriteLine("M=D");
		}

        WritePPop(writer);
        writer.WriteLine("D=M");

		if (index == "0")
		{
			writer.WriteLine($"@{segment}");
			if (virtualSegment)
			{
                writer.WriteLine("A=M");
            }
        }
		else
		{
			writer.WriteLine("@R15");
            writer.WriteLine("A=M");
        }

        writer.WriteLine("M=D");
        writer.WriteLine($"//END Pop to {segment}[{index}]");
    }

    private static void WritePPop(StreamWriter writer)
    {
        writer.WriteLine("//Partial Pop, point to memory address but don't move to register or operate on.");
        writer.WriteLine("@SP");
        writer.WriteLine("M=M-1");
        writer.WriteLine("A=M");
        writer.WriteLine("//END Partial Pop");

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