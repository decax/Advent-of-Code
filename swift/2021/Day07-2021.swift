import Foundation

fileprivate let gridSize = 1000

func Day07_2021() {
    let input = try! String(contentsOfFile: "2021/day07.data").dropLast() // we need to remove the last \n
    let numbers = input.split(separator: ",").map { Int($0)! }

    Part1(numbers: numbers)
    Part2(numbers: numbers)
}

fileprivate func Part1(numbers: [Int]) {

    var distances = [Int]()
    
    for number in 0 ... numbers.max()! {

        let r = numbers.reduce(0) { (result: Int, element: Int) -> Int in
            return result + abs(element - number)
        }

        distances.append(r)
    }
    
    print("\(distances.min()!)")
}

fileprivate func Part2(numbers: [Int]) {

    var distances = [Int]()

    for number in 0 ... numbers.max()! {

        let r = numbers.reduce(0) { (result: Int, element: Int) -> Int in
            return result + TriangleNumber(abs(element - number))
        }

        distances.append(r)
    }

    print("\(distances.min()!)")
}

fileprivate func TriangleNumber(_ number: Int) -> Int {
    return (number / 2) * number + (number.isMultiple(of: 2) ? number / 2 : number)
}
