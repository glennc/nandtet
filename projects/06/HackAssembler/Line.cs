using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HackAssembler
{
    internal class Line
    {
        public InstructionType InstructionType { get; set; }
        public string OriginalLine { get; set; }
    }
}
