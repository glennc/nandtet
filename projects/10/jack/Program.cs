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

    while(tokenizer.HasMoreTokens)
    {
        var token = tokenizer.Advance();
        Console.WriteLine($"Token: {token.TokenType} : {token.Source}");
    }
}

