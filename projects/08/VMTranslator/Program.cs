

using System.IO;

var directoryPath = args[0];
//TODO: Handle both files and folders
if(File.Exists(directoryPath) || !Directory.Exists(directoryPath))
{
    return;
}

var dirs = Directory.GetDirectories(directoryPath);
for (int i = 0; i < dirs.Length; i++)
{
    Console.WriteLine($"[{i}] {dirs[i]}");
}
var dirIndex = int.Parse(Console.ReadLine());
directoryPath = dirs[dirIndex];

bool bootstrap = Directory.GetFiles(directoryPath, "Sys.vm").Any();

string outFileName = Path.Combine(directoryPath, new DirectoryInfo(directoryPath).Name + ".asm");
var stream = new FileStream(outFileName, FileMode.Create, FileAccess.Write, FileShare.None);
var generator = new HackAssemblyGenerator(stream, bootstrap);

foreach (var file in Directory.EnumerateFiles(directoryPath, "*.vm"))
{
    var parser = new Parser(file);
    generator.SetFile(Path.GetFileNameWithoutExtension(file));

    while (parser.HasMoreLines)
    {
        parser.Advance();
        generator.Write(parser.CurrentCommand);
    }
}
generator.Done();
