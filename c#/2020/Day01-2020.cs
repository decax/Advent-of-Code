using System;
using System.IO;
using System.Linq;

namespace AdventOfCode.Year2020
{
	public class Day01
	{
		public Day01()
		{
			var data = File.ReadAllLines("2020/day01.data");
			var numbers = data.Select(x => int.Parse(x)).ToArray();

			Part1(numbers);
			Part2(numbers);
		}

		void Part1(int[] numbers)
		{
			for (int x = 0; x < numbers.Length; x++)
			{
				for (int y = x + 1; y < numbers.Length; y++)
				{
					if (numbers[x] + numbers[y] == 2020)
					{
						Console.WriteLine($"{numbers[x] * numbers[y]}");
						return;
					}
				}
			}
		}

		void Part2(int[] numbers)
		{
			for (int x = 0; x < numbers.Length; x++)
			{
				for (int y = x + 1; y < numbers.Length; y++)
				{
					for (int z = y + 1; z < numbers.Length; z++)
					{
						if (numbers[x] + numbers[y] + numbers[z] == 2020)
						{
							Console.WriteLine($"{numbers[x] * numbers[y] * numbers[z]}");
							return;
						}
					}
				}
			}
		}
	}
}
