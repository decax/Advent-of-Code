using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Advent_of_Code
{
    class Day06
    {
        List<int> data = new List<int>();

        public Day06()
        {
            var lines = File.ReadAllText("../data/day06.data");
            var numbers = lines.Split('\t');
            foreach (var number in numbers) {
                data.Add(Int32.Parse(number));
            }
            
            Part1();
            Part2();
        }

        public void Part1()
        {
            var set = new HashSet<int>();

            bool found = false;
            var counter = 0;
            while (!found) {
                counter++;

                var max = data.Max();
                var index = data.IndexOf(max);

                data[index] = 0;
                for (int i = 0; i < max; i++) {
                    var idx = (index + i + 1) % data.Count;
                    data[idx] = data[idx] + 1;
                }

                found = !set.Add(Hash(data));
            }

            Console.WriteLine("Part 1: {0}", counter);
        }

        int Hash(List<int> list)
        {
            const int seed = 487;
            const int modifier = 31;

            unchecked
            {
                return list.Aggregate(seed, (current, n) => (current * modifier) + n);
            }
        }

        public void Part2()
        {
            var dic = new Dictionary<int, int>();

            bool found = false;
            var counter = 0;
            var duplicateCounter = 0;
            while (!found) {
                counter++;

                var max = data.Max();
                var index = data.IndexOf(max);

                data[index] = 0;
                for (int i = 0; i < max; i++) {
                    var idx = (index + i + 1) % data.Count;
                    data[idx] = data[idx] + 1;
                }

                var hash = Hash(data);
                found = dic.ContainsKey(hash);
                if (!found) {
                    dic[hash] = counter;
                } else {
                    duplicateCounter = dic[hash];
                }
            }
            
            Console.WriteLine("Part 2: {0}", counter - duplicateCounter);
        }
    }
}