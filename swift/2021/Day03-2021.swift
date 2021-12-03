import Foundation

fileprivate let nbBits = 12

func Day03_2021() {
    
    let input = try! String(contentsOfFile: "2021/day03.data")
    let numbers = input.split(separator: "\n").compactMap() { Int($0, radix: 2) }

    Part1(numbers)
    Part2(numbers)
}

fileprivate func Part1(_ numbers: [Int]) {

    let bitCounts = countBits(numbers: numbers)
    
    var gammaRate = 0
    var epsilonRate = 0
    
    for x in 0 ..< nbBits {
        
        let ones = bitCounts[x]
        let zeroes = numbers.count - ones
        
        let bitFlag = 1 << (nbBits - 1 - x)
        
        if  ones > zeroes {
            gammaRate |= bitFlag
        } else {
            epsilonRate |= bitFlag
        }
    }

    print("\(gammaRate * epsilonRate)")
}

fileprivate func Part2(_ numbers: [Int]) {

    let oxygen = getRating(numbers: numbers, condition: >=)
    let co2 = getRating(numbers: numbers, condition: <)

    print("\(oxygen * co2)")
}

fileprivate func countBits(numbers: [Int]) -> [Int] {

    var bitCounts = [Int](repeating: 0, count: nbBits)
    
    for number in numbers {
        for x in 0 ..< nbBits {
            let bitFlag = 1 << (nbBits - 1 - x)
            if number & bitFlag != 0 {
                bitCounts[x] += 1 // count the 1s
            }
        }
    }
    
    return bitCounts
}

fileprivate func getRating(numbers: [Int], condition: (Int, Int) -> Bool) -> Int {
    
    var numbers = numbers
    
    for x in 0 ..< nbBits {
        
        let bitCounts = countBits(numbers: numbers)
        
        let ones = bitCounts[x]
        let zeroes = numbers.count - ones
                
        let bit = 1 << (nbBits - 1 - x)
        
        let keepBit = condition(ones, zeroes) ? bit : 0
        
        numbers.removeAll() { ($0 & bit) != keepBit }
        
        if numbers.count == 1 {
            return numbers.first!
        }
    }
    
    return 0
}
