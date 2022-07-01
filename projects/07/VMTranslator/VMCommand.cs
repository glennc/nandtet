

public class VMCommand
{
    public VMCommandType CommandType;
    public string Source;

    public string Arg1;
    public string Arg2;

    public VMCommand(string source)
    {
        Source = source;
    }
}

public class PushPopCommand : VMCommand
{
    public PushPopCommand(string source) : base(source)
    {
    }
}

public class ArithmaticCOmmand : VMCommand
{
    public ArithmaticCOmmand(string source) : base(source)
    {
    }
}

public enum VMCommandType
{
    C_ARITHMETIC,
    C_PUSH,
    C_POP,
    C_LABEL,
    C_GOTO,
    C_IF,
    C_FUNCTION,
    C_RETURN,
    C_CALL
}