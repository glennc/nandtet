var files = new List<string>();

if(args.Any())
{
    if(args[0].EndsWith(".jack"))
    {
        Console.WriteLine("Single File Mode");
        if(File.Exists(args[0]))
        {
            files.Add(args[0]);
        }
        else
        {
            Console.WriteLine($"Provided file doesn't exist {args[0]}");
            return;
        }
    }
    else
    {
        if(!Directory.Exists(args[0]))
        {
            Console.WriteLine($"Directory doesn't exist: {args[0]}");
            return;
        }
        files.AddRange(Directory.GetFiles(args[0], "*.jack"));
    }
}
else
{
    files.AddRange(Directory.GetFiles(Directory.GetCurrentDirectory(), "*.jack"));
}

Console.WriteLine($"Analyzing {files.Count()} files.");

foreach(var file in files)
{
    Console.WriteLine($"Analyzing {file}");
    var tokenizer = new JackTokenizer(file);
    var outFileName = Path.ChangeExtension(file, "xml");

    Console.WriteLine($"Creating file {outFileName}");

    using var outFile = File.CreateText(outFileName);
    //TODO: I kind of want to await tokens to get a token. Should look at that.
    var tokens = tokenizer.Advance().GetEnumerator();

    outFile.WriteLine("<tokens>");
    while(tokenizer.HasMoreTokens)
    {
        Process(tokens,outFile);
    }
    outFile.WriteLine("</tokens>");
}

void Process(IEnumerator<Token> tokens, TextWriter outFile)
{
    tokens.MoveNext();
    var token = tokens.Current;
    if(token is null) //TODO: If I make it a enumrator that I enumerate foreach(var token in tokens) this should become unnecesary.
    {
        return;
    }
    if(token.TokenType == TokenType.KEYWORD)
    {
        ProcessKeyword(tokens, outFile);
        return;
    }
    var output = token.TokenType switch 
    {
        //TokenType.KEYWORD => PrintKeyword(token, tokens),
        TokenType.IDENTIFIER => $"<identifier> {token.Source} </identifier>",
        TokenType.INT_CONST => $"<integerConstant> {token.Source} </integerConstant>",
        TokenType.STRING_CONST => $"<stringConstant> {token.Source} </stringConstant>",
        TokenType.SYMBOL => $"<symbol> {token.Source} </symbol>"
    };
    outFile.WriteLine(output);
}

void ProcessKeyword(IEnumerator<Token> tokens, TextWriter outFile)
{
    switch(tokens.Current.KeywordType)
    {
        case KeywordType.CLASS:
            PrintKeyword(tokens.Current, outFile);
            break;
        case KeywordType.FUNCTION:
            PrintFunction(tokens, outFile);
            break;
        default:
            outFile.WriteLine($"<keyword> {tokens.Current.Source} </keyword>");
            break;
    }
}

void PrintFunction(IEnumerator<Token> tokens, TextWriter outFile)
{
    //TODO: MOAR RECURSION.
    // outFile.WriteLine("<subroutineDec>");
        PrintKeyword(tokens.Current, outFile);
        tokens.MoveNext();
        PrintKeyword(tokens.Current, outFile);
        tokens.MoveNext();
        PrintIdentifier(tokens.Current, outFile);
        tokens.MoveNext();
        PrintSymbol(tokens.Current, outFile);
        // outFile.WriteLine("<parameterList>");
            //TODO: process parameterlist.
        // outFile.WriteLine("</parameterList>");
        tokens.MoveNext();
        PrintSymbol(tokens.Current, outFile);
        tokens.MoveNext();
        // outFile.WriteLine("<subroutineBody>");
        PrintSymbol(tokens.Current, outFile);
        // outFile.WriteLine("</subroutineBody>");
    // outFile.WriteLine("</subroutineDec>");
}

void PrintSymbol(Token token, TextWriter outFile)
{
    outFile.WriteLine($"<symbol> {token.Source} </symbol>");
}

void PrintKeyword(Token token, TextWriter outFile)
{
    outFile.WriteLine($"<keyword> {token.Source} </keyword>");
}

void PrintIdentifier(Token token, TextWriter outFile)
{
    outFile.WriteLine($"<identifier> {token.Source} </identifier>");
}

// string PrintKeyword(Token token, IEnumerable<Token> tokens)
// {
//     return token.KeywordType switch
//     {
//         KeywordType.CLASS => "<class>",
//         KeywordType.VAR => PrintVar(token, tokens),
//         KeywordType.LET => "<let>",
//         KeywordType.FUNCTION => "<function>",
//         KeywordType.VOID => "<void>",
//         KeywordType.INT => "<int>",
//         KeywordType.WHILE => "<while>",
//         KeywordType.DO => "<do>",
//         KeywordType.RETURN => "<return>",
//     };
// }

// string PrintVar(Token token, IEnumerable<Token> tokens)
// {
//     return "var";
// }

