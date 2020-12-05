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
        
        let rowPart = s[s.startIndex..<s.index(s.startIndex, offsetBy: 7)]
        
        row = 0
        for (i, c) in rowPart.enumerated() {
            if c == "B" {
                row |= 1 << (rowPart.count - i)
            }
        }
        
        let columnPart = s[s.index(s.startIndex, offsetBy: 7)..<s.endIndex]

        column = 0
        for (i, c) in columnPart.enumerated() {
            if c == "R" {
                column |= 1 << (columnPart.count - i)
            }
        }
    }
}
