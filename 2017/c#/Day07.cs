using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Advent_of_Code
{
    class Day07
    {
        class Tower
        {
            public string Name;
            public int Weight;
            public Tower Parent;
            public List<Tower> Childs = new List<Tower>();

            public int GetTotalWeight()
            {
                if (Childs.Count == 0) {
                    return Weight;
                }

                var childsWeight = Weight;
                foreach (var child in Childs) {
                    childsWeight += child.GetTotalWeight();
                }

                return childsWeight;
            }
        }

        Dictionary<string, Tower> towers = new Dictionary<string, Tower>();

        Tower rootTower = null;

        public Day07()
        {
            var lines = File.ReadAllLines("../data/day07.data");
            
            // Create all towers first
            foreach (var line in lines) {
                var elements = line.Split(' ');

                var name = elements[0];
                var weight = Int32.Parse(elements[1].TrimStart('(').TrimEnd(')'));
                towers[name] = new Tower { Name = name, Weight = weight };
            }
            
            // Create the childs / parents relationships
            foreach (var line in lines) {
                var elements = line.Split(' ');

                var tower = towers[elements[0]];
                for (int i = 3; i < elements.Length; i++) {
                    var childName = elements[i].TrimEnd(',');

                    var child = towers[childName];
                    child.Parent = tower;

                    tower.Childs.Add(child);
                }
            }

            Part1();
            Part2();
        }

        public void Part1()
        {
            rootTower = towers.Values.First(x => x.Parent == null);

            Console.WriteLine("Part 1: {0}", rootTower.Name);
        }

        public void Part2()
        {
            Tower differentChild = rootTower;
            Tower lastDifferentChild = differentChild;
            while (differentChild != null) {
                lastDifferentChild = differentChild;
                differentChild = GetDifferentChild(differentChild);
            }

            var parent = lastDifferentChild.Parent;
            var otherChild = parent.Childs.First(x => x != lastDifferentChild);
            var diff = otherChild.GetTotalWeight() - lastDifferentChild.GetTotalWeight();

            Console.WriteLine("Part 2: {0}", lastDifferentChild.Weight + diff);
        }

        Tower GetDifferentChild(Tower tower)
        {
            for (int i = 0; i < tower.Childs.Count; i++) {
                if (tower.Childs[i].GetTotalWeight() != tower.Childs[(i + 1) % tower.Childs.Count].GetTotalWeight() &&
                    tower.Childs[i].GetTotalWeight() != tower.Childs[(i + 2) % tower.Childs.Count].GetTotalWeight()) {
                        return tower.Childs[i];
                    }
            }

            return null;
        }
    }
}