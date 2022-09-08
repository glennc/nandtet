
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
        "neg",
        "not",
        "lt"
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

        command.CommandType = commandText switch
        {
            "push" => VMCommandType.C_PUSH,
            "pop" => VMCommandType.C_POP,
            "label" => VMCommandType.C_LABEL,
            "if-goto" => VMCommandType.C_IF,
            "goto" => VMCommandType.C_GOTO,
            "function" => VMCommandType.C_FUNCTION,
            "return" => VMCommandType.C_RETURN,
            "call" => VMCommandType.C_CALL,
            string when _arithmeticCommands.Contains(commandText) => VMCommandType.C_ARITHMETIC,
            _ => throw new Exception("Unknown command text")
        };

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