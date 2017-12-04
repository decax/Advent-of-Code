using System;
using System.Collections.Generic;
using System.Drawing;

namespace Advent_of_Code
{
    class Spiral
    {
        public Point Position { get; private set; } = new Point(0, 0);

        Size size = new Size(0, 0);
        
        Direction direction = Direction.Right;

        enum Direction {
            Right, Up, Left, Down
        }

        Dictionary<Direction, Size> movement = new Dictionary<Direction, Size> {
            { Direction.Right, new Size(1, 0)  }, 
            { Direction.Up,    new Size(0, 1)  }, 
            { Direction.Left,  new Size(-1, 0) }, 
            { Direction.Down,  new Size(0, -1) }
        };

        public void Advance()
        {
            Position += movement[direction];

            if (Math.Abs(GetPositionForDirection()) > GetSizeForDirection() / 2) {
                // Grow the spiral
                if      (direction == Direction.Up   || direction == Direction.Down)  size.Height++;
                else if (direction == Direction.Left || direction == Direction.Right) size.Width++;

                direction = ChangeDirection(direction);
            }
        }

        Direction ChangeDirection(Direction direction)
        {
            return (Direction)(((int)direction + 1) % Enum.GetValues(direction.GetType()).Length);
        }
        
        int GetPositionForDirection()
        {
            if (direction == Direction.Right || direction == Direction.Left) {
                return Position.X;
            }
            else {
                return Position.Y;
            }
        }

        int GetSizeForDirection()
        {
            if (direction == Direction.Right || direction == Direction.Left) {
                return size.Width;
            }
            else {
                return size.Height;
            }
        }
    }

    class Day03
    {
        int data = 325489;

        public Day03()
        {
            Part1();
            Part2();
        }

        public void Part1()
        {
            var spiral = new Spiral();
            
            for (int i = 1; i < data; i++) {
                spiral.Advance();
            }

            Console.WriteLine("Part 1: {0}", Math.Abs(spiral.Position.X) + Math.Abs(spiral.Position.Y));
        }

        public void Part2()
        {
            const int maxSize = 20;
            var matrix = new int[maxSize, maxSize];

            // Init everything to 0
            for (int x = 0; x < maxSize; x++) {
                for (int y = 0; y < maxSize; y++) {
                    matrix[x, y] = 0;
                }
            }

            // init first value with 1
            matrix[maxSize / 2, maxSize / 2] = 1;

            var spiral = new Spiral();

            var total = 0;
            while (total <= data) {
                spiral.Advance();

                var x = spiral.Position.X + maxSize / 2;
                var y = spiral.Position.Y + maxSize / 2;

                total = matrix[x - 1, y - 1] + 
                        matrix[x + 0, y - 1] + 
                        matrix[x + 1, y - 1] + 
                        matrix[x - 1, y + 0] + 
                        matrix[x + 1, y + 0] + 
                        matrix[x - 1, y + 1] + 
                        matrix[x + 0, y + 1] + 
                        matrix[x + 1, y + 1];

                matrix[x, y] = total;
            }

            Console.WriteLine("Part 2: {0}", total);
        }
    }
}