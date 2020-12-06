import Foundation

func Day01_2020() {
    let input = try! String(contentsOfFile: "2020/day01.data")
    let numbers = input.split(separator: "\n").compactMap { Int($0) }
    
    Part1(numbers: numbers)
    Part2(numbers: numbers)
}

fileprivate func Part1(numbers: [Int]) {
    for x in 0..<numbers.count {
        for y in x..<numbers.count {
            if numbers[x] + numbers[y] == 2020 {
                print(numbers[x] * numbers[y])
                return
            }
        }
    }
}

fileprivate func Part2(numbers: [Int]) {
    for x in 0..<numbers.count {
        for y in x..<numbers.count {
            for z in y..<numbers.count {
                if numbers[x] + numbers[y] + numbers[z] == 2020 {
                    print(numbers[x] * numbers[y] * numbers[z])
                    return
                }
            }
        }
    }
}
