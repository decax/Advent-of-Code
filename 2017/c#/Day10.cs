using System;
using System.Collections.Generic;
using System.IO;

namespace Advent_of_Code
{
    class Day10
    {
        List<int> lengths = new List<int>();
        string textInput;

        public Day10()
        {
            textInput = File.ReadAllText("../data/day10.data").TrimEnd('\n');
            var numbers = textInput.Split(',');
            foreach (var number in numbers) {
                lengths.Add(Int32.Parse(number));
            }

            Part1();
            Part2();
        }

        public void Part1()
        {
            int skipSize = 0;
            int position = 0;

            var numbers = new int[256];
            for (int i = 0; i < numbers.Length; i++) {
                numbers[i] = i;
            }

            foreach (var length in lengths) {
                Reverse(numbers, position, length);
                position += length + skipSize;
                position %= numbers.Length;
                skipSize++;
            }

            Console.WriteLine("Part 1: {0}", numbers[0] * numbers[1]);
        }

        void Reverse(int[] numbers, int from, int length) {
            for (int i = 0; i < length / 2; i++) {
                var x = (from + i) % numbers.Length;
                var y = (from + (length - 1) - i) % numbers.Length;
                
                var tmp = numbers[x];
                numbers[x] = numbers[y];
                numbers[y] = tmp;
            }
        }
        public void Part2()
        {
            byte[] extendedKey = { 17, 31, 73, 47, 23 };
            var key = new byte[textInput.Length + extendedKey.Length];
            for (int i = 0; i < textInput.Length; i++) {
                key[i] = (byte)textInput[i];
            }
            for (int i = 0; i < extendedKey.Length; i++) {
                key[textInput.Length + i] = extendedKey[i];
            }

            int skipSize = 0;
            int position = 0;

            var numbers = new int[256];
            for (int i = 0; i < numbers.Length; i++) {
                numbers[i] = i;
            }

            for (var round = 0; round < 64; round++) {
                foreach (var k in key) {
                    Reverse(numbers, position, k);
                    position += k + skipSize;
                    position %= numbers.Length;
                    skipSize++;
                }
            }
 
            byte[] denseHash = new byte[16];
            for (int i = 0; i < denseHash.Length; i++) {
                denseHash[i] = 0;
            }
            for (int i = 0; i < numbers.Length; i++) {
                denseHash[i / 16] ^= (byte)numbers[i];
            }

            var hashString = "";
            foreach (var x in denseHash) {
                hashString += x.ToString("X2");
            }

            Console.WriteLine("Part 2: {0}", hashString);
        }
    }
}