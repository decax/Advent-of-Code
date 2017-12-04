using System;
using System.IO;
using System.Linq;

namespace Advent_of_Code
{
    class Day02
    {
        int[][] data;

        public Day02()
        {
            var s = File.ReadAllText("../data/day02.data").TrimEnd('\n');

            var rows = s.Split('\n');
            data = new int[rows.Length][];

            for (int i = 0; i < rows.Length; i++) {
                var columns = rows[i].Split('\t');
                data[i] = new int[columns.Length];
                for (int j = 0; j < columns.Length; j++) {
                    data[i][j] = Int16.Parse(columns[j]);
                }
            }

            Part1();
            Part2();
        }

        public void Part1()
        {
            var checksum = 0;

            foreach (var row in data) {
                checksum += row.Max() - row.Min();
            }

            Console.WriteLine("checksum 1: {0}", checksum);
        }

        public void Part2()
        {
            var checksum = 0;

            foreach (var row in data) {
                foreach (var n1 in row) {
                    foreach (var n2 in row) {
                        if (n1 != n2 && n1 >= n2 && n1 % n2 == 0) {
                            checksum += n1 / n2;
                        }
                    }
               }
            }

            Console.WriteLine("checksum 2: {0}", checksum);
        }
    }
}