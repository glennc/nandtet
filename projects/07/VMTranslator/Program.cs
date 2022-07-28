

var fileName = args[0];

if(!File.Exists(fileName))
{
    return;
}

var parser = new Parser(fileName);

string outFileName = fileName.Replace(".vm", ".asm");

//var generator = new HackAssemblyGenerator(Console.OpenStandardOutput());
var stream = new FileStream(outFileName, FileMode.Create, FileAccess.Write, FileShare.None);
var generator = new HackAssemblyGenerator(stream, Path.GetFileNameWithoutExtension(fileName));

while(parser.HasMoreLines)
{
    parser.Advance();
    generator.Write(parser.CurrentCommand);
}
generator.Done();
