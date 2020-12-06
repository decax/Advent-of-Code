import Foundation

func Day02_2020() {
    let input = try! String(contentsOfFile: "2020/day02.data")
    let entries = input.split(separator: "\n").compactMap { DataEntry(String($0)) }
    
    Part1(entries: entries)
    Part2(entries: entries)
}

fileprivate func Part1(entries: [DataEntry]) {
    var valid = 0
    
    for entry in entries {
        let count = entry.password.filter { $0 == entry.letter }.count
        if count >= entry.lowest && count <= entry.highest {
            valid += 1
        }
    }
    
    print(valid)
}

fileprivate func Part2(entries: [DataEntry]) {
    var valid = 0
  
    for entry in entries {
        if (entry.password[entry.lowest - 1] == entry.letter) != (entry.password[entry.highest - 1] == entry.letter) {
            valid += 1
        }
    }
        
    print(valid)
}

struct DataEntry {
    let lowest: Int
    let highest: Int
    
    let letter: Character
    let password: String
    
    init(_ line: String) {
        let regex = try! NSRegularExpression(pattern: "^(\\d+)-(\\d+) (\\w): (\\w+)")
        let range = NSRange(location: 0, length: line.utf16.count)
        let match = regex.firstMatch(in: line, options: [], range: range)

        lowest = Int(line[Range(match!.range(at: 1), in: line)!])!
        highest = Int(line[Range(match!.range(at: 2), in: line)!])!
        
        letter = Character(String(line[Range(match!.range(at: 3), in: line)!]))
        password = String(line[Range(match!.range(at: 4), in: line)!])
    }
}

