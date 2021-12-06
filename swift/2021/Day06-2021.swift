import Foundation

fileprivate let gridSize = 1000

func Day06_2021() {
    let input = try! String(contentsOfFile: "2021/day06.data").dropLast() // we need to remove the last \n
    let numbers = input.split(separator: ",").map { Int($0)! }

    Part1(numbers: numbers)
    Part2(numbers: numbers)
}

fileprivate func Part1(numbers: [Int]) {

    print("\(simulate(numbers: numbers, numberOfDays: 80))")
}

fileprivate func Part2(numbers: [Int]) {

    print("\(simulate(numbers: numbers, numberOfDays: 256))")
}

fileprivate func simulate(numbers: [Int], numberOfDays: Int) -> Int {
    
    let newLanternfishTimer = 8
    let oldLanternfishTimer = 6
    
    var nbOfLanternfishesPerTimer = [Int](repeating: 0, count: newLanternfishTimer + 1)
    for number in numbers {
        nbOfLanternfishesPerTimer[number] = nbOfLanternfishesPerTimer[number] + 1
    }
    
    for _ in 0 ..< numberOfDays {
        
        var numberToAdd = 0
        
        for i in 0 ..< nbOfLanternfishesPerTimer.count {
            if i == 0 {
                numberToAdd = nbOfLanternfishesPerTimer[i]
            } else {
                nbOfLanternfishesPerTimer[i - 1] = nbOfLanternfishesPerTimer[i]
            }
        }
        
        nbOfLanternfishesPerTimer[newLanternfishTimer] = numberToAdd
        nbOfLanternfishesPerTimer[oldLanternfishTimer] += numberToAdd
    }
    
    return nbOfLanternfishesPerTimer.reduce(0, +)
}
