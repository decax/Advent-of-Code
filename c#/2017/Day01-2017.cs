using System;
using System.IO;

namespace Advent_of_Code
{
    class Day01
    {
        int[] data;

        public Day01()
        {
            var s = File.ReadAllText("../data/day01.data").TrimEnd('\n');
            data = new int[s.Length];

            for (int i = 0; i < s.Length; i++) {
                data[i] = (int)char.GetNumericValue(s[i]);
            }

            Part1();
            Part2();
        }

        public void Part1()
        {
            Console.WriteLine("Captcha 1: {0}", Captcha(1));
        }

        public void Part2()
        {
            Console.WriteLine("Captcha 2: {0}", Captcha(data.Length / 2));
        }

        int Captcha(int period)
        {
            var total = 0;

            for (int i = 0; i < data.Length; i++) {
                var i1 = data[i];
                var i2 = data[(i + period) % data.Length];

                if (i1 == i2) {
                    total += i1;
                }
            }

            return total;
        }
    }
}