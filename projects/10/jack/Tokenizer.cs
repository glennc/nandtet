using System.IO;

public class JackTokenizer : IDisposable
{
    private string _file;
    private StreamReader _inputStream;

    private List<string> _keywords = new List<string> {
        "class",
        "constructor",
        "function",
        "method",
        "field",
        "static",
        "var",
        "int",
        "char",
        "boolean",
        "void",
        "true",
        "false",
        "null",
        "this",
        "let",
        "do",
        "if",
        "else",
        "while",
        "return"
    };

    private List<char> _symbols = new List<char> {
        '{','}','(',')','[',']','.',',',';','+','-','*','/','&','|','<','>','=','~'
    };

    public bool HasMoreTokens
    {
        get
        {
            return !_inputStream.EndOfStream;
        }
    }

    public JackTokenizer(string file)
    {
        _file = file;
        _inputStream = new StreamReader(File.OpenRead(file));
    }

    public Token Advance()
    {
        string line;
        do
        {
            line = _inputStream.ReadLine().Trim();
        }
        while (string.IsNullOrWhiteSpace(line) || line.StartsWith("//"));

        if (line.Contains("//"))
        {
            line = line.Split("//")[0].Trim();
        }

        //TODO: Handle /* and */

        var token = new Token(line);


        if(_symbols.Contains(line[0]))
        {
            token.TokenType = TokenType.SYMBOL;
            token.Source = line[0].ToString();
        }
        else
        {        
            string currentToken = "";
            foreach(var character in line)
            {
                currentToken += character;
                if(_keywords.Contains(currentToken))
                {
                    token.TokenType = TokenType.KEYWORD;
                    token.KeywordType = Enum.Parse<KeywordType>(currentToken, true);
                }
            }
            token.Source = currentToken;
        }

        return token;
    }

    public void Dispose()
    {
        _inputStream.Close();
        _inputStream.Dispose();
    }
}

public enum TokenType
{
    KEYWORD,
    SYMBOL,
    IDENTIFIER,
    INT_CONST,
    STRING_CONST
}

public enum KeywordType
{
    CLASS,
    METHOD,
    FUNCTION,
    CONSTRUCTOR,
    INT,
    BOOLEAN,
    CHAR,
    VOID,
    VAR,
    STATIC,
    FIELD,
    LET,
    DO,
    IF,
    ELSE,
    WHILE,
    RETURN,
    TRUE,
    FALSE,
    NULL,
    THIS
}