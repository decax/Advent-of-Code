using System;
using System.IO;

namespace Advent_of_Code
{
    class Day09
    {
        int score = 0;
        int collectedGarbage = 0;

        public Day09()
        {
            var text = File.ReadAllText("../data/day09.data");

            var groupScore = 0;
            bool garbage = false;
            for (int i = 0; i < text.Length; i++) {
                switch (text[i]) {
                    case '<':
                        if (!garbage) {
                            garbage = true;
                        } else {
                            collectedGarbage++;
                        }
                        break;
                    
                    case '>':
                        garbage = false;
                        break;

                    case '!':
                        i++;
                        break;

                    case '{':
                        if (!garbage) {
                            groupScore++;
                        } else {
                            collectedGarbage++;
                        }
                        break;

                    case '}':
                        if (!garbage) {
                            score += groupScore;
                            groupScore--;
                        } else {
                            collectedGarbage++;
                        }
                        break;

                    default:
                        if (garbage) {
                            collectedGarbage++;
                        }
                        break;
                }
            }
            
            Part1();
            Part2();
        }

        public void Part1()
        {
            Console.WriteLine("Part 1: {0}", score);
        }

        public void Part2()
        {
            Console.WriteLine("Part 2: {0}", collectedGarbage);
        }
    }
}