import Foundation

func fuelRequirement(for weight: Int) -> Int {
    return weight / 3 - 2
}

func Day01_2019() {
    let input = try! String(contentsOfFile: "2019/day01.data")
    let fuelRequirements = input.split(separator: "\n")

    var totalFuel = 0
    for line in fuelRequirements {
        var r = fuelRequirement(for: Int(line)!)
        totalFuel += r
        
        var r2 = 0
        while (r > 0) {
            let r3 = fuelRequirement(for: r)
            if r3 > 0 {
                r2 += r3
            }
            r = r3
        }
        
        totalFuel += r2
        
    }

    print(totalFuel)

    var suppFuel = totalFuel
    while suppFuel > 0 {
        let r = fuelRequirement(for: suppFuel)
        if r > 0 {
            totalFuel += r
        }
        
        suppFuel = r
    }

    print(totalFuel)
}
