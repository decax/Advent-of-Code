import Foundation


fileprivate var program = [Instruction]()

func Day08_2020() {
    let input = try! String(contentsOfFile: "2020/day08.data")
    program = input.split(separator: "\n").map { Instruction(line: String($0)) }
    
    Part1()
    Part2()
}

fileprivate func Part1() {
    
    let computer = Computer()
    computer.Load(instructions: program)
    _ = computer.Run()
    
    print(computer.accumulator)
   
}

fileprivate func Part2() {
    let computer = Computer()
    computer.Load(instructions: program)
    
    var error = true
    
    var lastChange = 0
    
    var newInstructions = program
    
    repeat {
        computer.Load(instructions: newInstructions)
        computer.Reset()
        error = computer.Run()
        
        if error {
            newInstructions = program
            
            // change a nop to jmp or jmp to nop
            if let address = findFrom(instructions: newInstructions, from: lastChange + 1) {
                lastChange = address
                var newInstruction = newInstructions[address]
                newInstruction.operation = newInstruction.operation == "nop" ? "jmp" : "nop"
                newInstructions[address] = newInstruction
            }
        }
    } while error
    
    print(computer.accumulator)
}

func findFrom(instructions: [Instruction], from: Int) -> Int? {
    for i in from..<instructions.count {
        if instructions[i].operation == "nop" ||  instructions[i].operation == "jmp"{
            return i
        }
    }
    
    return nil
}

struct Instruction {
    var operation: String
    var argument: Int
    
    init(line: String) {
        let x = line.split(separator: " ")
        
        operation = String(x[0])
        argument = Int(x[1])!
    }
}

class Computer {
    
    var pc = 0
    var accumulator = 0
    
    var instructions = [Instruction]()
    
    func Load(instructions: [Instruction]) {
        self.instructions = instructions
        
        Reset()
    }
    
    func Reset() {
        pc = 0
        accumulator = 0
    }
    
    func Run() -> Bool {
        var executedAddresses = Set<Int>()
        var error = false
        
        while !error && pc < instructions.count {
            
            executedAddresses.insert(pc)
            
            let instruction = instructions[pc]
            
            switch instruction.operation {
            case "acc":
                accumulator += instruction.argument
                pc += 1

            case "nop":
                pc += 1

            case "jmp":
                pc += instruction.argument
            
            default:
                error = true
                print("invalid")
            }
            
            if executedAddresses.contains(pc) {
                error = true
            }
        }

        return error
    }
}
