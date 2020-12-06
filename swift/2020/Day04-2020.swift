import Foundation

func Day04_2020() {
    let input = try! String(contentsOfFile: "2020/day04.data")
    
    var passports = [Dictionary<String, String>]()

    let passportStrings = input.components(separatedBy: "\n\n").map { $0.replacingOccurrences(of: "\n", with: " ")}
    for passportString in passportStrings {
        var passport = Dictionary<String, String>()

        let fields = passportString.split(separator: " ")
        for field in fields {
            let subfields = field.split(separator: ":")
            
            passport[String(subfields[0])] = String(subfields[1])
        }

        passports.append(passport)
    }
    
    Part1(passports: passports)
    Part2(passports: passports)
}

fileprivate func Part1(passports: [Dictionary<String, String>]) {
    
    print(passports.filter { passport in HasAllRequiredFields(passport: passport) }.count)
}

fileprivate func Part2(passports: [Dictionary<String, String>]) {
    print(passports.filter { passport in HasAllRequiredFields(passport: passport) && passport.allSatisfy { field in IsFieldValid(field: field.key, value: field.value) } }.count)
}

fileprivate func HasAllRequiredFields(passport: Dictionary<String, String>) -> Bool {
    let requiredFields = [ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" ]
    
    return requiredFields.allSatisfy { passport.index(forKey: $0) != nil }
}

fileprivate func IsFieldValid(field: String, value: String) -> Bool {
    switch field {

    case "byr":
        if let val = Int(value) {
            return val >= 1920 && val <= 2002
        }
        
    case "iyr":
        if let val = Int(value) {
            return val >= 2010 && val <= 2020
        }
    
    case "eyr":
        if let val = Int(value) {
            return val >= 2020 && val <= 2030
        }
        
    case "hgt":
        if let number = Int(value[0..<value.count - 2]) {
            if value.hasSuffix("cm") {
                return number >= 150 && number <= 193
            } else if (value.hasSuffix("in")) {
                return number >= 59 && number <= 76
            }
        }
        
    case "hcl":
        let number = value[1..<value.count]
        return value.hasPrefix("#") && number.count == 6 && Int(number, radix: 16) != nil
        
    case "ecl":
        let eyeColors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        return eyeColors.contains(value)

    case "pid":
        return Int(value) != nil && value.count == 9
    
    case "cid":
        return true

    default:
        return false
    }
    
    return false
}
