import Foundation

func Day03_2020() {
    let input = try! String(contentsOfFile: "2020/day03.data")
    
    let lines = input.split(separator: "\n")
    var map = Array(repeating: Array(repeating: false, count: lines[0].count), count: lines.count)
    
    for (y, line) in lines.enumerated() {
        for (x, character) in line.enumerated() {
            map[y][x] = character == "#"
        }
    }

    Part1(map: map)
    Part2(map: map)
}

fileprivate func Part1(map: [[Bool]]) {
    let hits = TreesHit(map: map, slope: (x: 3, y: 1))
    
    print(hits)
}

fileprivate func Part2(map: [[Bool]]) {
    let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    let product = slopes.reduce(1) { $0 * TreesHit(map: map, slope: $1) }
    
    print(product)
}

fileprivate func TreesHit(map: [[Bool]], slope: (x: Int, y: Int)) -> Int {
    var x = 0
    var y = 0
    
    var hits = 0
    
    while y < map.count {
        if map[y][x] {
            hits += 1
        }
        
        x = (x + slope.x) % map[y].count
        y += slope.y
    }
    
    return hits
}
