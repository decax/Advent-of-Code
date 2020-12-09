import Foundation


fileprivate var numbers = [Int]()

func Day09_2020() {
    let input = try! String(contentsOfFile: "2020/day09.data")
    
    numbers = input.split(separator: "\n").compactMap() { Int($0) }
    
    let invalidNumber = Part1()
    Part2(invalidNumber: invalidNumber)
}

fileprivate func Part1() -> Int {
    let preamble = 25
    
    for i in preamble..<numbers.count {
        var found = false
        for j in (i - preamble)..<i {
            for k in (j + 1)..<i {
                if numbers[j] + numbers[k] == numbers[i] {
                    found = true
                }
            }
        }
        
        if !found {
            print(numbers[i])
            return numbers[i]
        }
    }
    
    return 0
}

fileprivate func Part2(invalidNumber: Int) {
    for i in 0..<numbers.count {
        for j in (i + 1)..<numbers.count {
            let contiguousSet = numbers[i..<j]
            
            if contiguousSet.reduce(0, +) == invalidNumber {
                print(contiguousSet.min()! + contiguousSet.max()!)
                return
            }
        }
    }
}
