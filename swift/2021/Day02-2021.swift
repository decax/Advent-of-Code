import Foundation

func Day02_2021() {
    
    let input = try! String(contentsOfFile: "2021/day02.data")
    let instructions = input.split(separator: "\n").map() { (line: Substring) -> Instruction in
        let words = line.split(separator: " ")
        return Instruction(direction: String(words[0]), units: Int(words[1])!)
    }
    
    Part1(instructions)
    Part2(instructions)
}

fileprivate func Part1(_ instructions: [Instruction]) {
    
    var horizontal = 0
    var depth = 0
    
    for instruction in instructions {
        
        switch instruction.direction {
        
        case "down":    depth += instruction.units
        case "up":      depth -= instruction.units
        case "forward": horizontal += instruction.units
        
        default: ()
        }
    }
    
    print("\(horizontal * depth)")
}

fileprivate func Part2(_ instructions: [Instruction]) {
    
    var horizontal = 0
    var depth = 0
    var aim = 0
    
    for instruction in instructions {
        
        switch instruction.direction {

        case "down":
            aim += instruction.units

        case "up":
            aim -= instruction.units

        case "forward":
            horizontal += instruction.units
            depth += aim * instruction.units
        
        default: ()
        }
    }
    
    print("\(horizontal * depth)")
}

fileprivate struct Instruction {
    var direction: String
    var units: Int
}
