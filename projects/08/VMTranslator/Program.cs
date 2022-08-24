

using System.IO;

var directoryPath = args[0];
//TODO: Handle both files and folders
if(File.Exists(directoryPath) || !Directory.Exists(directoryPath))
{
    return;
}

string outFileName = Path.Combine(directoryPath, new DirectoryInfo(directoryPath).Name + ".asm");
var stream = new FileStream(outFileName, FileMode.Create, FileAccess.Write, FileShare.None);
var generator = new HackAssemblyGenerator(stream);

foreach (var file in Directory.EnumerateFiles(directoryPath, "*.vm"))
{
    var parser = new Parser(file);
    generator.SetFile(Path.GetFileNameWithoutExtension(directoryPath));

    while (parser.HasMoreLines)
    {
        parser.Advance();
        generator.Write(parser.CurrentCommand);
    }
}
generator.Done();
