import Foundation

func Day01() {
    let input = try! String(contentsOfFile: "day01.data")

    // Transform the data into an array of int
    let changes = input.split(separator: "\n").compactMap { Int($0) }
    
    Part1(changes: changes)
    Part2(changes: changes)
}

// Find total frequency
fileprivate func Part1(changes: [Int]) {
    let frequency = changes.reduce(0, +)

    print(frequency)
}

// Find first frequency that appears twice
fileprivate func Part2(changes: [Int]) {
    
    var frequenciesUsed = Set<Int>()
    
    var frequency = 0
    var i = 0
    
    while !frequenciesUsed.contains(frequency) {
        
        frequenciesUsed.insert(frequency)
        
        frequency += changes[i]
        
        i = (i + 1) % changes.count
    }
    
    print(frequency)
}
