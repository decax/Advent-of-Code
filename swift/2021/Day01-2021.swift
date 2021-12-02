import Foundation

func Day01_2021() {
    let input = try! String(contentsOfFile: "2021/day01.data")
    let numbers = input.split(separator: "\n").compactMap { Int($0) }
    
    Part1(numbers: numbers)
    Part2(numbers: numbers)
}

fileprivate func Part1(numbers: [Int]) {
    var numberOfIncreases = 0
    for i in 1 ..< numbers.count {
        if numbers[i] > numbers[i - 1] {
            numberOfIncreases += 1
        }
    }
    
    print("\(numberOfIncreases)")
}

fileprivate func Part2(numbers: [Int]) {
    let windowSize = 3
    
    var numberOfIncreases = 0
    
    var previous = numbers[0 ..< windowSize].reduce(0, +)
    
    for i in 1 ... numbers.count - windowSize {
    
        let current = numbers[i ..< i + windowSize].reduce(0, +)
        
        if current > previous {
            numberOfIncreases += 1
        }
        
        previous = current
    }
    
    print("\(numberOfIncreases)")
}
