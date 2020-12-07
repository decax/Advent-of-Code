import Foundation

fileprivate var colors = Set<String>()
fileprivate var rules = Dictionary<String, [HoldedBags]>()

func Day07_2020() {
    let input = try! String(contentsOfFile: "2020/day07.data")
    
    // shitty parsing
    for line in input.split(separator: "\n") {
        
        let endFirstPart = line.range(of: " bags contain ")!
        
        let bagType = line[line.startIndex..<endFirstPart.lowerBound]
        
        // Build a list of all existing bag colors
        colors.insert(String(bagType))
        
        var holdedBags = [HoldedBags]()
        let results = line[endFirstPart.upperBound..<line.firstIndex(of: ".")!].components(separatedBy: ", ")
        for result in results {
            
            if (result != "no other bags") {
            
                let b = result[result.startIndex..<result.range(of: " bag")!.lowerBound]
                
                let count = b[b.startIndex..<b.index(b.startIndex, offsetBy: 1)]
                let type = b[b.index(b.startIndex, offsetBy: 2)..<b.endIndex]
                
                holdedBags.append(HoldedBags(type: String(type), count: Int(count)!))
            }
        }
        
        rules[String(bagType)] = holdedBags
    }
    
    Part1()
    Part2()
}

fileprivate func Part1() {
    
    var count = 0
    
    for color in colors {
        if CanHold(bag: color, bag2: "shiny gold") {
            count += 1
        }
    }
    
    print(count)
}

fileprivate func Part2() {
    print(CountBags(bag: "shiny gold") - 1)
}

fileprivate func CountBags(bag: String) -> Int {
    var total = 1
    
    for rule in rules[bag]! {
        total += CountBags(bag: rule.type) * rule.count
    }

    return total
}

fileprivate func CanHold(bag: String, bag2: String) -> Bool {
    
    for rule in rules[bag]! {
        if rule.type == bag2 {
            return true
        } else {
            if CanHold(bag: rule.type, bag2: bag2) {
                return true
            }
        }
    }
    
    return false
}

struct HoldedBags {
    let type: String
    let count: Int
}
