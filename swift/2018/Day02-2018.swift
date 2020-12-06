import Foundation

func Day02_2018() {
    let input = try! String(contentsOfFile: "2018/day02.data")
    let ids = input.split(separator: "\n")
    
    Part1(ids: ids)
    Part2(ids: ids)
}

fileprivate func Part1(ids: [Substring]) {
    var letterCountsPerWords = [Substring: [Character: Int]]()

    for id in ids {
        var letterCounts = [Character: Int]()
        
        for letter in id {
            if let count = letterCounts[letter] {
                letterCounts[letter] = count + 1
            } else {
                letterCounts[letter] = 1
            }
        }
        
        letterCountsPerWords[id] = letterCounts
    }

    let containsTwo = letterCountsPerWords.values.filter( { $0.values.contains(2) } ).count
    let containsThree = letterCountsPerWords.values.filter( { $0.values.contains(3) } ).count
    
    let checksum = containsTwo * containsThree
    
    print(checksum)
}

fileprivate func Part2(ids: [Substring]) {
    compareLoop: for i in 0..<ids.count {
        for j in i..<ids.count {
            
            let id1 = ids[i]
            let id2 = ids[j]
            
            let diff = DifferenceScore(a: id1, b: id2)
        
            if diff == 1 {
                
                // Remove the different character from the string
                var result = ""
                for (a, b) in zip(id1, id2) {
                    if a == b {
                        result.append(a)
                    }
                }
                
                print(result)
                break compareLoop // no need to check further
            }
        }
    }
}

func DifferenceScore<T: StringProtocol>(a: T, b: T) -> Int {
    var diff = 0
    for (l1, l2) in zip(a, b) {
        if l1 != l2 {
            diff += 1
        }
    }
    
    return diff
}
