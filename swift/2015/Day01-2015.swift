import Foundation

func Day01_2015() {
    let input = try! String(contentsOfFile: "2015/day01.data")
    
    Part1(directions: input)
    Part2(directions: input)
}

fileprivate func Part1(directions: String) {
    var floor = 0
    
    for direction in directions {
        switch direction {
        case "(":
            floor += 1
        case ")":
            floor -= 1
        default:
            print("error")
        }
    }
    
    print("\(floor)")
}

fileprivate func Part2(directions: String) {
    var position = 1
    var floor = 0

    for direction in directions {
        switch direction {
        case "(":
            floor += 1
        case ")":
            floor -= 1
        default:
            print("error")
        }
        
        if floor == -1 {
            break
        } else {
            position += 1
        }
    }
    
    print("\(position)")
}
