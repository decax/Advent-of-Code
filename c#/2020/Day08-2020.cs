using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace AdventOfCode.Year2020
{
	public class Day08
	{
		List<Instruction> instructions = new List<Instruction>();

		public Day08()
		{
			var input = File.ReadAllLines("2020/day08.data");

			foreach (var line in input)
			{
				instructions.Add(new Instruction(line));
			}

			Part1();
			Part2();
		}

		void Part1()
		{
			var computer = new Computer();
			computer.Load(instructions);

			computer.Run();

			Console.WriteLine(computer.Accumulator);
		}

		void Part2()
		{
			var computer = new Computer();
			computer.Load(instructions);

			var error = false;

			int lastInstructionIndex = 0;

			do
			{
				error = computer.Run();

				// Mutate nop to jmp or jmp to nop
				if (error)
				{
					var newInstructions = new List<Instruction>(instructions);

					newInstructions.Find((i) => i.Operation == "nop" || i.Operation == "jmp");
					var index = newInstructions.FindIndex(lastInstructionIndex + 1, (i) => i.Operation == "nop" || i.Operation == "jmp");

					var instruction = newInstructions[index];
					instruction.Operation = instruction.Operation == "nop" ? "jmp" : "nop";
					newInstructions[index] = instruction;

					lastInstructionIndex = index;

					computer.Load(newInstructions);
				}
			} while (error);
			

			Console.WriteLine(computer.Accumulator);
		}
	}

	struct Instruction
	{
		public string Operation;
		public int Argument;

		public Instruction(string line)
		{
			var parts = line.Split(" ");

			Operation = parts[0];
			Argument = int.Parse(parts[1]);
		}
	}

	class Computer
	{
		public int PC = 0;
		public int Accumulator = 0;

		public List<Instruction> Instructions;

		public void Load(List<Instruction> instructions)
		{
			Instructions = instructions;

			Reset();
		}

		void Reset()
		{
			PC = 0;
			Accumulator = 0;
		}

		public bool Run()
		{
			var addresses = new HashSet<int>();

			while (PC < Instructions.Count)
			{
				addresses.Add(PC);

				var instruction = Instructions[PC];

				switch (instruction.Operation)
				{
					case "acc":
						Accumulator += instruction.Argument;
						PC++;
						break;

					case "nop":
						PC++;
						break;

					case "jmp":
						PC += instruction.Argument;
						break;
				}

				if (addresses.Contains(PC))
				{
					return true;
				}

			}

			return false;
		}
	}
}
