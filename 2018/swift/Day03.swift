import Foundation

func Day03() {
    let input = try! String(contentsOfFile: "day03.data")

    // Transform the data into an array of Claim
    let lines = input.split(separator: "\n")
    
    let pattern = "#([0-9]+) @ ([0-9]+),([0-9]+): ([0-9]+)x([0-9]+)"

    var claims = [Claim]()
    
    for l in lines {
        let line = String(l)
        let values = line.regex(pattern)
        
        claims.append(Claim(id: values[0], rect: CGRect(origin: CGPoint(x: Int(values[1])!, y: Int(values[2])!), size: CGSize(width: Int(values[3])!, height: Int(values[4])!))))
    }
    
    Part1(claims)
    Part2(claims)
}

fileprivate func Part1(_ claims: [Claim]) {
    
    var claimedPoints = [CGPoint: Int]()
    var nbDoubleClaimedPoints = 0
    
    for claim in claims {
        for point in claim.rect.getAllPoints() {

            var newValue: Int
            
            if let nbClaimed = claimedPoints[point] {
                newValue = nbClaimed + 1
                
                if newValue == 2 {
                    nbDoubleClaimedPoints = nbDoubleClaimedPoints + 1
                }
            } else {
                newValue = 1
            }
            
            claimedPoints.updateValue(newValue, forKey: point)
        }
    }
    
    print(nbDoubleClaimedPoints)
}

fileprivate func Part2(_ claims: [Claim]) {

    for claim in claims {
        if claims.filter( { claim != $0 && $0.rect.intersects(claim.rect) } ).count == 0 {
            print(claim.id)
            break
        }
    }
}

struct Claim: Comparable {
    let id: String
    let rect: CGRect

    static func < (lhs: Claim, rhs: Claim) -> Bool {
        return lhs.id < rhs.id
    }
}

extension CGRect {
    func getAllPoints() -> [CGPoint] {
        var points = [CGPoint]()
        
        let x = Int(self.origin.x)
        let y = Int(self.origin.y)
        let w = Int(self.width)
        let h = Int(self.height)
        
        for i in x..<x+w {
            for j in y..<y+h {
                points.append(CGPoint(x: i, y: j))
            }
        }
        
        return points
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension String {
    func regex(_ expression: String) -> [String] {
        
        var captured = [String]()
        
        let regex = try! NSRegularExpression(pattern: expression)
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        
        for match in matches {
            for i in 1...match.numberOfRanges - 1 {
                let range = match.range(at: i)
                if let swiftRange = Range(range, in: self) {
                    captured.append(String(self[swiftRange]))
                }
            }
        }
        
        return captured
    }
}
