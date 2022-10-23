using System.IO;
using System.Text;
using System.Text.RegularExpressions;

public class JackTokenizer : IDisposable
{
    private string _file;
    private StreamReader _inputStream;

    private Regex _commentRegex = new Regex("/\\*(.)*?\\*/");

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

    private List<string> _symbols = new List<string> {
        "{","}","(",")","[","]",".",",",";","+","-","*","/","&","|","<",">","=","~"
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

    public IEnumerable<Token> Advance()
    {
        while(HasMoreTokens)
        {
            string line = string.Empty;
            do
            {
                line = _inputStream.ReadLine();

                if(line is null)
                {
                    yield return null;
                }

                line = line.Trim();

                line = _commentRegex.Replace(line ?? "", "");
            }
            while (string.IsNullOrWhiteSpace(line) || line.StartsWith("//"));

            if (line.Contains("//"))
            {
                line = line.Split("//")[0].Trim();
            }

            string currentSource = "";
            bool inString = false;

            if(line.StartsWith("/*"))
            {
                do
                {
                    line = _inputStream.ReadLine()?.Trim();
                }
                while(!line.EndsWith("*/"));
                line = _inputStream.ReadLine()?.Trim();
            }

            foreach(var inChar in line)
            {
                if(inString)
                {
                    if(inChar == '"')
                    {
                        yield return new Token(line){
                            TokenType = TokenType.STRING_CONST,
                            Source = currentSource
                        };
                        currentSource = "";
                        inString = false;
                        continue;
                    }
                    currentSource += inChar;
                    continue;
                }

                if(Char.IsWhiteSpace(inChar))
                {
                    //discards leading whitespace after known keywords.
                    if(string.IsNullOrEmpty(currentSource))
                        continue;
                    
                    if(int.TryParse(currentSource, out _))
                    {
                        yield return new Token(line) {
                            TokenType = TokenType.INT_CONST,
                            Source = currentSource
                        };
                    }
                    else
                    {
                        var token = new Token(line);
                        token.TokenType = TokenType.IDENTIFIER;
                        token.Source = currentSource;
                        yield return token;
                    }
                    currentSource = "";
                    continue;
                }

                if(_symbols.Contains(inChar.ToString()))
                {
                    if(!string.IsNullOrEmpty(currentSource))
                    {
                        if(int.TryParse(currentSource, out _))
                        {
                            yield return new Token(line) {
                                TokenType = TokenType.INT_CONST,
                                Source = currentSource
                            };
                        }
                        else
                        {
                            yield return new Token(line) {
                                TokenType = TokenType.IDENTIFIER,
                                Source = currentSource
                            };
                        }
                    }
                    var token = new Token(line);
                    token.TokenType = TokenType.SYMBOL;
                    token.Source = inChar.ToString();
                    yield return token;
                    currentSource = "";
                    continue;
                }

                if(inChar == '"')
                {
                    inString = true;
                    continue;   
                }

                currentSource += inChar;
                
                if(_keywords.Contains(currentSource))
                {
                    var token = new Token(line);
                    token.TokenType = TokenType.KEYWORD;
                    token.KeywordType = Enum.Parse<KeywordType>(currentSource, true);
                    token.Source = currentSource;
                    yield return token;
                    currentSource = "";
                    continue;
                }
            }
        }
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