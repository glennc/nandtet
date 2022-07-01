// See https://aka.ms/new-console-template for more information
using HackAssembler;
using System.Collections;
using System.Text;

var inputFile = args[0];

var parser = new Parser(inputFile);
var generator = new Generator();
using var f = File.OpenWrite("output.txt");
using var sw = new StreamWriter(f);

    do
    {
        await parser.Advance();
        var binary = new StringBuilder();
        if (parser.GetInstructionType() == InstructionType.A_INSTRUCTION || parser.GetInstructionType() == InstructionType.L_INSTRUCTION)
        {
            var s = parser.Symbol();
            binary.Append(generator.symbol(s));
            //await sw.WriteLineAsync(binary.ToString());
            Console.WriteLine(binary.ToString());
        }
        else
        {
            binary.Append(generator.comp(parser.Comp()));
            binary.Append(generator.dest(parser.Dest()));
            binary.Append(generator.jump(parser.Jump()));
            //await sw.WriteLineAsync(binary.ToString());
            Console.WriteLine(binary.ToString());
        }

    } while (parser.HasMoreLines);

Console.ReadLine();
