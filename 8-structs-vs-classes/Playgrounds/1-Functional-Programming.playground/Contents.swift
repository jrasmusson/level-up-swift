/*

         ___             _   _               _
        | __|  _ _ _  __| |_(_)___ _ _  __ _| |
        | _| || | ' \/ _|  _| / _ \ ' \/ _` | |
        |_| \_,_|_||_\__|\__|_\___/_||_\__,_|_|

  ___                                    _
 | _ \_ _ ___  __ _ _ _ __ _ _ __  _ __ (_)_ _  __ _
 |  _/ '_/ _ \/ _` | '_/ _` | '  \| '  \| | ' \/ _` |
 |_| |_| \___/\__, |_| \__,_|_|_|_|_|_|_|_|_||_\__, |
              |___/                            |___/


 */

// Pure function
func double(_ value: Int) -> Int {
    return value * 2
}
let doubled = double(2)

// Immutability
let somethingThatCantBeChanged = "unchangeable"

// Higher order functions
var numbers = [1, 2, 3, 4, 5, 6]

let oddNumbers = numbers.filter { $0 % 2 == 1 }
let squared = oddNumbers.map{ $0 * $0 }
let summed = squared.reduce(0) { $0 + $1 }

// Declarative
func doubleValue(_ numbers: [Int]) -> [Int] {
    var result = [Int]()
    for number in numbers {
        result.append(number * 2)
    }
    return result
}

let imperative = doubleValue(numbers)    // How

// vs Imperative
let declarative = numbers.map { $0 * 2 } // What


