public class Token
{
    public Token(string sourceLine)
    {
        SourceLine = sourceLine;
    }

    public string SourceLine {get;set;}
    public string Source {get;set;}
    public KeywordType KeywordType{get;set;}
    public TokenType TokenType {get; set;}
}