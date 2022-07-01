using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HackAssembler
{
    public class Parser : IDisposable
    {
        public bool HasMoreLines { get; set; }

        private StreamReader _inputStream;
        private InstructionType _currentInstructionType;
        private string _currentLine;

        private Dictionary<string, int> _symbols;
        private int _lineCount;
        private int _pass;
        private string _inputPath;

        public Parser(string inputPath)
        {
            _inputStream = new StreamReader(File.OpenRead(inputPath));
            _symbols = new Dictionary<string, int>();
            _lineCount = 0;
            HasMoreLines = true;
            _pass = 0;
            _inputPath = inputPath;
        }

        private async Task BuildSymbolTable()
        {
            var lineCount = 0;
            var line = string.Empty;
            var inputStream = new StreamReader(File.OpenRead(_inputPath));

            while (!inputStream.EndOfStream)
            {
                do
                {
                    line = await inputStream.ReadLineAsync();
                }
                while (string.IsNullOrWhiteSpace(line) || line.StartsWith("//"));

                if (line.Contains("//"))
                {
                    line = line.Split("//")[0].Trim();
                }

                lineCount++;

                if (line.StartsWith("("))
                {
                    _symbols.Add(line.Trim().TrimStart('(').TrimEnd(')'), lineCount);
                }
            }
            _pass++;
        }

        public async Task Advance()
        {
            if (_pass == 0)
            {
                await BuildSymbolTable();
            }

            var line = string.Empty;
            do
            {
                line = await _inputStream.ReadLineAsync();
            }
            while (string.IsNullOrWhiteSpace(line) || line.StartsWith("//") || line.StartsWith("("));

            if (line.Contains("//"))
            {
                line = line.Split("//")[0].Trim();
            }

            _currentLine = line.Trim();
            _lineCount++;

            if (_currentLine.Contains("=") || _currentLine.Contains(";"))
            {
                _currentInstructionType = InstructionType.C_INSTRUCTION;
            }
            else if (_currentLine.Contains("@"))
            {
                _currentInstructionType = InstructionType.A_INSTRUCTION;
                if (_symbols.ContainsKey(_currentLine.TrimStart('@')))
                {
                    _currentLine = "@" + _symbols[_currentLine.TrimStart('@')];
                }
            }
            else
            {
                _currentInstructionType = InstructionType.L_INSTRUCTION;
                if (_symbols.ContainsKey(_currentLine))
                {
                    _currentLine = _symbols[_currentLine].ToString();
                }
            }

            if (_inputStream.EndOfStream)
            {
                HasMoreLines = false;
            }
        }

        public InstructionType GetInstructionType()
        {
            return _currentInstructionType;
        }

        public string Symbol()
        {
            switch (_currentInstructionType)
            {
                case InstructionType.C_INSTRUCTION:
                    throw new Exception($"Can only call symbol method when instruction type is C, current instruction is {_currentInstructionType}");
                case InstructionType.A_INSTRUCTION:
                    return _currentLine.Remove(0, 1);
                case InstructionType.L_INSTRUCTION:
                    return _currentLine;
                default:
                    throw new Exception("Unhandled instruction type");
            }
        }

        public string Dest()
        {
            if (_currentInstructionType != InstructionType.C_INSTRUCTION)
            {
                throw new Exception("Can only call Dest for C_INSTRUCTIONS");
            }


            if (_currentLine.Contains(";"))
            {
                var c = _currentLine.Split(";")[0];
                if (!c.Contains("="))
                {
                    return "null";
                }
            }

            if (_currentLine.Contains("="))
            {
                return _currentLine.Split("=")[0];
            }

            return "null";
        }

        public string Comp()
        {
            if (_currentInstructionType != InstructionType.C_INSTRUCTION)
            {
                throw new Exception("Can only call Comp for C_INSTRUCTIONS");
            }
            if (_currentLine.Contains("="))
            {
                return _currentLine.Split("=")[1];
            }
            else
            {
                return _currentLine.Split(";")[0];
            }
        }

        public string Jump()
        {
            if (_currentInstructionType != InstructionType.C_INSTRUCTION)
            {
                throw new Exception("Can only call Jump for C_INSTRUCTIONS");
            }

            var jmp = _currentLine.Split(";");

            if (_currentLine.Contains(";"))
            {
                return _currentLine.Split(";")[1];
            }
            
            return "null";
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }

    public enum InstructionType
    {
        A_INSTRUCTION,
        C_INSTRUCTION,
        L_INSTRUCTION
    }
}
