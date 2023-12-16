import Algorithms
import Foundation

struct Day12: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map {
            String($0)
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var sum = 0
        for line in entities {
            
            let length = line.filter{ $0 == "." || $0 == "?" || $0 == "#" }.count
            
            let scanner = Scanner(string: String(line))
            scanner.charactersToBeSkipped = CharacterSet(arrayLiteral: ".", "?", "#", ",", " ")
            var numbers = [Int]()
            while !scanner.isAtEnd {
                if let number = scanner.scanInt() {
                    numbers.append(number)
                }
            }
            
            let fillments = makeFillment(numbers: numbers, length: length)
            for fillment in fillments {
                let tempate = line.split(separator: " ").first!
                if check(attempt: fillment, template: String(tempate)) {
                    sum += 1
                }
            }
            
        }
        return sum
    }
    
    private func makeFillment(numbers: [Int], length: Int) -> [String] {
        if numbers.count == 1 {
            var strings = [String]()
            for i in 0 ... length - numbers[0] {
                var string = ""
                for _ in 0 ..< i {
                    string += "."
                }
                
                for _ in 0 ..< numbers[0] {
                    string += "#"
                }
                
                for _ in 0 ..< length - numbers[0] - i {
                    string += "."
                }
                
                strings.append(string)
            }
            return strings
        }
        
        var strings = [String]()
        
        var spaceForOtherNumbers = 0
        for i in 1 ... numbers.count - 1 {
            spaceForOtherNumbers += numbers[i] + 1
        }
        spaceForOtherNumbers -= 1
        
        for i in 0 ..< length - numbers[0] - spaceForOtherNumbers {
            var string = ""
            for _ in 0 ..< i {
                string += "."
            }
            for _ in 0 ..< numbers[0] {
                string += "#"
            }
            string += "."
            
            let remainNumbers = Array(numbers.dropFirst())
            let recursiveStrings = makeFillment(numbers: remainNumbers, length: length - string.count)
            for recursiveString in recursiveStrings {
                let resultString = string + recursiveString
                strings.append(resultString)
            }
        }
        return strings
    }
    
    private func check(attempt: String, template: String) -> Bool {
        let scanner = Scanner(string: template)
        scanner.charactersToBeSkipped = CharacterSet(arrayLiteral: "?")
        
        while !scanner.isAtEnd {
            if let symbol = scanner.scanCharacter() {
                let searchIndex = attempt.index(scanner.currentIndex, offsetBy: -1)
                if symbol == "." {
                    if String(attempt[searchIndex]) != "." {
                        return false
                    }
                }
                if symbol == "#" {
                    if String(attempt[searchIndex]) != "#" {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return false
    }
}
