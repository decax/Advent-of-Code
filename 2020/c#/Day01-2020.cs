using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

namespace AdventOfCode.Year2020
{
	public class Day01
	{
		public Day01()
		{
			var data = File.ReadAllLines("day01.data");
			var numbers = data.Select((x) => int.Parse(x));

			Part1(numbers);
			Part2(numbers);
		}

		void Part1(IEnumerable<int> numbers)
		{
			foreach (var x in numbers)
			{
				foreach (var y in numbers)
				{
					if (x != y && x + y == 2020)
					{
						Console.WriteLine($"{x * y}");
						return;
					}
				}
			}
		}

		void Part2(IEnumerable<int> numbers)
		{
			foreach (var x in numbers)
			{
				foreach (var y in numbers)
				{
					foreach (var z in numbers)
					{
						if (x != y && x != z && y != z && x + y + z == 2020)
						{
							Console.WriteLine($"{x * y * z}");
							return;
						}
					}
				}
			}
		}
	}
}
