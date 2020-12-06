import Foundation

func Day06_2020() {
    let input = try! String(contentsOfFile: "2020/day06.data")
    
    var answers = [[String]]()
    
    for (i, group) in input.components(separatedBy: "\n\n").enumerated() {
        answers.append([String]())
        
        for person in group.split(separator: "\n") {
            answers[i].append(String(person))
        }
    }
    
    Part1(answers: answers)
    Part2(answers: answers)
}

fileprivate func Part1(answers: [[String]]) {

    var total = 0
    
    for group in answers {
        
        var yes = Dictionary<Character, Int>()
        
        for person in group {
            for char in person {
                if let n = yes[char] {
                    yes[char] = n + 1
                } else {
                    yes[char] = 1
                }
            }
        }
        
        total += yes.count
    }
    
    print(total)
}

fileprivate func Part2(answers: [[String]]) {

    var total = 0
    
    for group in answers {
        
        var yes = Dictionary<Character, Int>()
        
        for person in group {
            for char in person {
                if let n = yes[char] {
                    yes[char] = n + 1
                } else {
                    yes[char] = 1
                }
            }
        }
        
        total += yes.filter { $0.value == group.count}.count
    }
    
    print(total)
}
