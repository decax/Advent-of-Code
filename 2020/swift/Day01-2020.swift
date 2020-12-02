import Foundation

func Day01() {
    let input = try! String(contentsOfFile: "day01.data")
    let numbers = input.split(separator: "\n").compactMap { Int($0) }
    
    Part1(numbers: numbers)
    Part2(numbers: numbers)
}

fileprivate func Part1(numbers: [Int]) {
    for x in numbers {
        for y in numbers {
            if x != y && x + y == 2020 {
                print(x * y)
                return
            }
        }
    }
}

fileprivate func Part2(numbers: [Int]) {
    for x in numbers {
        for y in numbers {
            for z in numbers {
                if x != y && x != z && y != z && x + y + z == 2020 {
                    print(x * y * z)
                    return
                }
            }
        }
    }
}
