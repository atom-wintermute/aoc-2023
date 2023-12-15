import Algorithms
import Foundation

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map {
            String($0)
        }
    }
    
    let redMax = 12
    let greenMax = 13
    let blueMax = 14
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var sum: Int = 0
        for (index, line) in entities.enumerated() {
            print(line)
            
            let scanner = Scanner(string: String(line))
            scanner.charactersToBeSkipped = CharacterSet(arrayLiteral: ".", "*", "=", "&", "%", "@", "/", "$", "+", "#", "-")
            while !scanner.isAtEnd {
                if let number = scanner.scanInt() {
                    let currentIndex = scanner.currentIndex
                    let numberOfDigits = numberOfDigits(in: number)
                    
                    // LEFT SYMBOL
                    if line.index(currentIndex, offsetBy: -numberOfDigits) > line.startIndex {
                        let leftIndex = line.index(currentIndex, offsetBy: -numberOfDigits - 1)
                        
                        let symbol = line[leftIndex]
                        if String(symbol) != "." {
                            sum += number
                            continue
                        }
                    }
                    
                    // RIGHT SYMBOL
                    if currentIndex < line.endIndex {
                        let symbol = line[currentIndex]
                        if String(symbol) != "." {
                            sum += number
                            continue
                        }
                    }
                    
                    // BOTTOM
                    if index < entities.count - 1 {
                        let nextLine = entities[index + 1]
                        
                        // LEFT SYMBOL
                        if line.index(currentIndex, offsetBy: -numberOfDigits) > line.startIndex {
                            let leftIndex = line.index(currentIndex, offsetBy: -numberOfDigits - 1)
                            
                            let symbol = nextLine[leftIndex]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                        
                        // RIGHT SYMBOL
                        if currentIndex < line.endIndex {
                            let symbol = nextLine[currentIndex]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                        
                        // BOTTOM SYMBOLS
                        for i in 0...numberOfDigits - 1 {
                            let symbol = nextLine[nextLine.index(currentIndex, offsetBy: -i - 1)]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                    }
                    
                    // TOP
                    if index > 0 {
                        let previousLine = entities[index - 1]
                        
                        // LEFT SYMBOL
                        if line.index(currentIndex, offsetBy: -numberOfDigits) > line.startIndex {
                            let leftIndex = line.index(currentIndex, offsetBy: -numberOfDigits - 1)
                            
                            let symbol = previousLine[leftIndex]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                        
                        // RIGHT SYMBOL
                        if currentIndex < line.endIndex {
                            let symbol = previousLine[currentIndex]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                        
                        // BOTTOM SYMBOLS
                        for i in 0...numberOfDigits - 1 {
                            let symbol = previousLine[previousLine.index(currentIndex, offsetBy: -i - 1)]
                            if String(symbol) != "." {
                                sum += number
                                continue
                            }
                        }
                    }
                }
            }
        }
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return false
    }
    
    private func numberOfDigits(in number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number / 10)
        }
    }
}
