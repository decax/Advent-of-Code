import Foundation

func Day05_2020() {
    let input = try! String(contentsOfFile: "2020/day05.data")
    let tickets = input.split(separator: "\n").map() { Ticket(String($0)) }
    
    Part1(tickets: tickets)
    Part2(tickets: tickets)
}

fileprivate func Part1(tickets: [Ticket]) {
    print(tickets.max() { $0.id < $1.id }!.id)
}

fileprivate func Part2(tickets: [Ticket]) {
    let sortedById = tickets.sorted { $0.id < $1.id }
    
    for i in 1..<tickets.count {
        if sortedById[i].id - sortedById[i - 1].id > 1 {
            print(sortedById[i].id - 1)
            break
        }
    }
}

struct Ticket {
    var row: Int
    var column: Int

    var id: Int { row * 8 + column }
    
    init(_ s: String) {
        
        let rowPart = s[0..<7]
        row = rowPart.enumerated().reduce(0) { (val, arg1) in let (index, char) = arg1; return val | (char == "B" ? 1 << (rowPart.count - index) : 0) }
        
        let columnPart = s[7..<9]
        column = columnPart.enumerated().reduce(0) { (val, arg1) in let (index, char) = arg1; return val | (char == "R" ? 1 << (columnPart.count - index) : 0) }
    }
}
