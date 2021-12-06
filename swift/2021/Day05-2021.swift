import Foundation

fileprivate let gridSize = 1000

func Day05_2021() {
    let input = try! String(contentsOfFile: "2021/day05.data")
    let lines = input.split(separator: "\n").map { (line: Substring) -> Line in
        
        // Format: "x1,y1 -> x2,y2"
        let  pairs = line.split(separator: " ")
        let coordinates1 = pairs[0].split(separator: ",")
        let coordinates2 = pairs[2].split(separator: ",")
        
        return Line(x1: Int(coordinates1[0])!, y1: Int(coordinates1[1])!, x2: Int(coordinates2[0])!, y2: Int(coordinates2[1])!)
    }
    
    Part1(lines: lines)
    Part2(lines: lines)
}

fileprivate func Part1(lines: [Line]) {

    var grid = [[Int]](repeating: [Int](repeating: 0, count: gridSize), count: gridSize)
    
    for line in lines {
        
        // vertical
        if line.x1 == line.x2 {
            DrawVertical(grid: &grid, line: line)
        }

        // horizontal
        if line.y1 == line.y2 {
            DrawHorizontal(grid: &grid, line: line)
        }
    }

    print("\(CountOverlaps(grid: grid))")
}

fileprivate func Part2(lines: [Line]) {

    var grid = [[Int]](repeating: [Int](repeating: 0, count: gridSize), count: gridSize)
    
    for line in lines {
        
        // vertical
        if line.x1 == line.x2 {
            DrawVertical(grid: &grid, line: line)
        }

        // horizontal
        if line.y1 == line.y2 {
            DrawHorizontal(grid: &grid, line: line)
        }
        
        // diagonal
        if abs(line.y2 - line.y1) == abs(line.x2 - line.x1) {
            DrawDiagonal(grid: &grid, line: line)
        }
    }

    print("\(CountOverlaps(grid: grid))")
}

fileprivate struct Line {
    var x1 = 0, y1 = 0, x2 = 0, y2 = 0
}

fileprivate func DrawVertical(grid: inout [[Int]], line: Line) {
    let x = line.x1
    for y in min(line.y1, line.y2)...max(line.y1, line.y2) {
        grid[x][y] += 1
    }
}

fileprivate func DrawHorizontal(grid: inout [[Int]], line: Line) {

    let y = line.y1
    for x in min(line.x1, line.x2)...max(line.x1, line.x2) {
        grid[x][y] += 1
    }
}

fileprivate func DrawDiagonal(grid: inout [[Int]], line: Line) {
    var x = 0
    var offset = 0
    
    if line.y1 < line.y2 {
        x = line.x1
        offset = line.x1 < line.x2 ? 1 : -1
        
    } else {
        x = line.x2
        offset = line.x2 < line.x1 ? 1 : -1
    }
    
    for y in min(line.y1, line.y2)...max(line.y1, line.y2) {
        grid[x][y] += 1
        
        x += offset
    }
}

fileprivate func CountOverlaps(grid: [[Int]]) -> Int {
    var total = 0
    
    for y in 0 ..< gridSize {
        for x in 0 ..< gridSize {
            if grid[x][y] > 1 {
                total += 1
            }
        }
    }
    
    return total
}
