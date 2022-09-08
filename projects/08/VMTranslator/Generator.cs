

using System.Xml.Serialization;

public class HackAssemblyGenerator : IDisposable
{
	private Stream _output;
	private StreamWriter _outputWriter;
	private string _fileName;
    private Random _rnd = new Random();

    public HackAssemblyGenerator(Stream output, string filename) : this(output)
	{
		_fileName = filename;
	}

	public HackAssemblyGenerator(Stream stream)
	{
		_output = stream;
        _outputWriter = new StreamWriter(stream);

        //Initialize VM.
        _outputWriter.WriteLine("@256");
        _outputWriter.WriteLine("D=A");
        _outputWriter.WriteLine("@SP");
        _outputWriter.WriteLine("M=D");

		var cmd = new VMCommand("call Sys.init 0")
		{
			Arg1 = "Sys.init",
			Arg2 = "0",
			CommandType = VMCommandType.C_CALL
		};
		WriteCall(cmd);

		//_outputWriter.WriteLine("@Sys.init");
		//_outputWriter.WriteLine("0;JMP");
    }

    internal void SetFile(string fileName)
    {
        _fileName = fileName;
    }

    public void Write(VMCommand command)
	{
		_outputWriter.WriteLine("//Command:" + command.Source);
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
				WriteFunction(command);
				break;
			case VMCommandType.C_RETURN:
				WriteReturn(command);
				break;
			case VMCommandType.C_CALL:
				WriteCall(command);
				break;
			default:
				throw new NotImplementedException();
		};
	}

	private void WriteCall(VMCommand command)
	{
		//label ID for return address.
		//TODO: This can probably just be a constant string with an incrementing ID.
		var returnId = _rnd.Next().ToString("x");
		SaveSegment(returnId);
		SaveSegment("LCL");
		SaveSegment("ARG");
		SaveSegment("THIS");
		SaveSegment("THAT");

		//Point ARG at the first ARG value being sent to the function.
		//which is SP-5-nVarArgs
		_outputWriter.WriteLine($"@{5+int.Parse(command.Arg2)}");
        _outputWriter.WriteLine("D=A");
        _outputWriter.WriteLine("@SP");
        _outputWriter.WriteLine("D=M-D");
		_outputWriter.WriteLine("@ARG");
		_outputWriter.WriteLine("M=D");

		//position LCL which should be at SP.
		_outputWriter.WriteLine("@SP");
		_outputWriter.WriteLine("D=M");
		_outputWriter.WriteLine("@LCL");
		_outputWriter.WriteLine("M=D");

		_outputWriter.WriteLine($"@{command.Arg1}");
		_outputWriter.WriteLine("0;JMP");

        _outputWriter.WriteLine($"({returnId})");
    }

    private void SaveSegment(string segment)
	{
        _outputWriter.WriteLine($"@{segment}");
        _outputWriter.WriteLine("D=A");
        WritePushDToStack(_outputWriter);
    }

	private void WriteReturn(VMCommand command)
	{
        _outputWriter.WriteLine("//return");

		//LCL should be at the beginning of the stored FRAME that we need to revert to.
		_outputWriter.WriteLine("@LCL");
		_outputWriter.WriteLine("D=M");
		_outputWriter.WriteLine("@R13");
		_outputWriter.WriteLine("M=D");

		//now go back 5 from R13 to get the return address.
		ResetFromFrame("R14", 5);

		//point ARG at the return value as the caller expects.
		_outputWriter.WriteLine("@SP");
		_outputWriter.WriteLine("A=M-1");
		_outputWriter.WriteLine("D=M");
		_outputWriter.WriteLine("@ARG");
		_outputWriter.WriteLine("A=M");
		_outputWriter.WriteLine("M=D");

		//Point SP to ARG +1
		_outputWriter.WriteLine("@ARG");
		_outputWriter.WriteLine("D=M+1");
		_outputWriter.WriteLine("@SP");
		_outputWriter.WriteLine("M=D");

		ResetFromFrame("THAT", 1);
		ResetFromFrame("THIS", 2);
		ResetFromFrame("ARG", 3);
		ResetFromFrame("LCL", 4);

        //goto return addres that was saved in R14.
        _outputWriter.WriteLine("@R14");
		_outputWriter.WriteLine("A=M");
		_outputWriter.WriteLine("0;JMP");
    }

	private void ResetFromFrame(string segment, int index)
	{
        //From the reference point of R13 move backwards by index and assign that to the given segment. Allows implementing segment = *(frame - index) pg161
        _outputWriter.WriteLine("@R13");
		if (index == 1)
		{
			_outputWriter.WriteLine("A=M-1");
		}
		else
		{
			_outputWriter.WriteLine("D=M");
			_outputWriter.WriteLine($"@{index}");
			_outputWriter.WriteLine("A=D-A");
		}
        _outputWriter.WriteLine("D=M");
        _outputWriter.WriteLine($"@{segment}");
        _outputWriter.WriteLine("M=D");
    }

    private void WriteFunction(VMCommand command)
	{
		//TODO: Probably shouldn't scatter the assembly syntax for writing a label around the file.
		//Write label for function name.
        _outputWriter.WriteLine($"({command.Arg1})");
		//Setup functions memory.
		_outputWriter.WriteLine("D=0");
        for (int i = 0; i < int.Parse(command.Arg2); i++)
		{
			//WritePop(_outputWriter, "ARG", i.ToString());
			WritePushDToStack(_outputWriter);
			//WritePushSegmentToStack(_outputWriter, "ARG", i.ToString());
		}
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