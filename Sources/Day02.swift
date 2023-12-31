import Algorithms
import Foundation

struct Day02: AdventDay {
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
        var sumOfValidGames = 0
        for game in entities {
            var gameNumber: Int = 0
            if let startIndex = game.range(of: "Game "), let endIndex = game.range(of: ": ") {
                gameNumber = Int(game[startIndex.upperBound..<endIndex.lowerBound])!
                
                var isGameValid = true
                
                var remainString = game[endIndex.upperBound...]
                let scanner = Scanner(string: String(remainString))
                scanner.charactersToBeSkipped = CharacterSet(arrayLiteral: ";", " ", ",")
                
                while !scanner.isAtEnd {
                    if let number = scanner.scanInt() {
                        if let red = scanner.scanString("red") {
                            if number > redMax {
                                isGameValid = false
                            }
                            continue
                        }
                        if let blue = scanner.scanString("blue") {
                            if number > blueMax {
                                isGameValid = false
                            }
                            continue
                        }
                        if let green = scanner.scanString("green") {
                            if number > greenMax {
                                isGameValid = false
                            }
                            continue
                        }
                    } else {
                        break
                    }
                }
                if isGameValid {
                    sumOfValidGames += gameNumber
                }
            }
        }
        return sumOfValidGames
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var sumOfPowers = 0
        for game in entities {
            print("game = \(game)")
            if let startIndex = game.range(of: "Game "), let endIndex = game.range(of: ": ") {
                let gameNumber = Int(game[startIndex.upperBound..<endIndex.lowerBound])!
                
                var remainString = game[endIndex.upperBound...]
                let scanner = Scanner(string: String(remainString))
                scanner.charactersToBeSkipped = CharacterSet(arrayLiteral: ";", " ", ",")
                
                var maxRed = -1
                var maxBlue = -1
                var maxGreen = -1
                
                while !scanner.isAtEnd {
                    if let number = scanner.scanInt() {
                        print("number = \(number)")
                        if let red = scanner.scanString("red") {
                            print("red")
                            maxRed = max(number, maxRed)
                            continue
                        }
                        if let blue = scanner.scanString("blue") {
                            print("blue")
                            maxBlue = max(number, maxBlue)
                            continue
                        }
                        if let green = scanner.scanString("green") {
                            print("green")
                            maxGreen = max(number, maxGreen)
                            continue
                        }
                    } else {
                        break
                    }
                }
                if maxRed > 0 && maxBlue > 0 && maxGreen > 0 {
                    sumOfPowers += (maxRed * maxBlue * maxGreen)
                }
            }
        }
        return sumOfPowers
    }
}
