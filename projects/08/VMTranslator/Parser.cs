
public class Parser
{
    public bool HasMoreLines 
    { 
        get
        {
            return !_inputStream.EndOfStream;
        } 
    }

    private string _fileName;
    private StreamReader _inputStream;

    public VMCommand CurrentCommand;

    public Parser(string fileName)
    {
        _fileName = fileName;
        _inputStream = new StreamReader(File.OpenRead(fileName));
    }

    private List<string> _arithmeticCommands = new List<string>()
    {
        "add",
        "sub",
        "neg"
    };

    public void Advance()
    {
        string line;
        do
        {
            line = _inputStream.ReadLine().Trim();
        }
        while (string.IsNullOrWhiteSpace(line) || line.StartsWith("//"));

        var command = new VMCommand(line);

        if (line.Contains("//"))
        {
            line = line.Split("//")[0].Trim();
        }

        var commandSegments = line.Split(" ");
        var commandText = commandSegments[0];

        if (commandText == "push")
        {
            command.CommandType = VMCommandType.C_PUSH;
        }
        else if (commandText == "pop")
        {
            command.CommandType = VMCommandType.C_POP;
        }
        else if (commandText.Contains("label"))
        {
            command.CommandType = VMCommandType.C_LABEL;
        }
        else if (commandText.Contains("if-goto"))
        {
            command.CommandType = VMCommandType.C_IF;
        }
        else if (commandText.Contains("goto"))
        {
            command.CommandType = VMCommandType.C_GOTO;
        }
        else if (_arithmeticCommands.Contains(commandText))
        {
            command.CommandType = VMCommandType.C_ARITHMETIC;
        }

        if (commandSegments.Length == 1)
        {
            command.Arg1 = commandSegments[0];
        }
        else if (commandSegments.Length >= 2)
        {
            command.Arg1 = commandSegments[1];
        }
        if(commandSegments.Length == 3)
        {
            command.Arg2 = commandSegments[2];
        }

        CurrentCommand = command;
    }

}