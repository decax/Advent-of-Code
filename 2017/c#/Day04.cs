using System;
using System.Linq;
using System.IO;
using System.Collections.Generic;

namespace Advent_of_Code
{
    class Day04
    {
        string[] data;

        public Day04()
        {
            data = File.ReadAllLines("../data/day04.data");

            Part1();
            Part2();
        }

        public void Part1()
        {
            var total = 0;

            foreach (var line in data) {
                var words = line.Split(' ');
                var l = new List<string>();
                bool valid = true;
                foreach (var word in words) {
                    if (l.Contains(word)) {
                        valid = false;
                    }
                    else {
                        l.Add(word);
                    }
                }

                if (valid) {
                    total++;
                }
            }

            Console.WriteLine("Part 1: {0}", total);
        }

        public void Part2()
        {
            var total = 0;

            foreach (var line in data) {
                var words = line.Split(' ');
                var l = new List<string>();
                bool valid = true;
                foreach (var word in words) {
                    var sortedWord = String.Concat(word.OrderBy(c => c));
                    if (l.Contains(sortedWord)) {
                        valid = false;
                    }
                    else {
                        l.Add(sortedWord);
                    }
                }

                if (valid) {
                    total++;
                }
            }

            Console.WriteLine("Part 2: {0}", total);
        }
    }
}