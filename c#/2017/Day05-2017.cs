using System;
using System.IO;

namespace Advent_of_Code
{
    class Day05
    {
        int[] data;

        public Day05()
        {
            var lines = File.ReadAllLines("../data/day05.data");
            
            data = new int[lines.Length];
            for (int i = 0; i < lines.Length; i++) {
                data[i] = Int32.Parse(lines[i]);
            }

            Part1();
            Part2();
        }

        public void Part1()
        {
            var jumpOffsets = new int[data.Length];
            Array.Copy(data, jumpOffsets, data.Length);

            var counter = 0;
            var index = 0;

            while (index < jumpOffsets.Length) {
                var offset = jumpOffsets[index];
                
                jumpOffsets[index] = offset + 1;
                
                index += offset;

                counter++;
            }

            Console.WriteLine("Part 1: {0}", counter);
        }

        public void Part2()
        {
            var jumpOffsets = new int[data.Length];
            Array.Copy(data, jumpOffsets, data.Length);

            var counter = 0;
            var index = 0;

            while (index < jumpOffsets.Length) {
                var offset = jumpOffsets[index];
                
                if (offset >= 3) {
                    jumpOffsets[index] = offset - 1;
                } else {
                    jumpOffsets[index] = offset + 1;
                }
                
                index += offset;

                counter++;
            }

            Console.WriteLine("Part 2: {0}", counter);
        }
    }
}