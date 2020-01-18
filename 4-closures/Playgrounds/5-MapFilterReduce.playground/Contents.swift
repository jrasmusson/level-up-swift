/*
  __  __             ___ _ _ _             ___        _
 |  \/  |__ _ _ __  | __(_) | |_ ___ _ _  | _ \___ __| |_  _ __ ___
 | |\/| / _` | '_ \ | _|| | |  _/ -_) '_| |   / -_) _` | || / _/ -_)
 |_|  |_\__,_| .__/ |_| |_|_|\__\___|_|   |_|_\___\__,_|\_,_\__\___|
             |_|
 aka Higher Order Functions
 */

/*
 A higher order function is a function that does at least one of the following:
 - takes a function as an input
 - returns a function as the output

 Swift has three important higher order functions implemented for arrays:
 map, filter and reduce.
 */

//
// Map - transforms an array using a function.
//

// [ x1, x2, ... , xn].map(f) -> [f(x1), f(x2), ... , f(xn)]
// i.e. [1, 2, 3] -> ["1", "2", "3"]

// One way

var numbers1 = [1, 2, 3]
var strings1: [String] = []
for number in numbers1 {
    strings1.append("\(number)")
}

// But a better way

var numbers2 = [1, 2, 3]
var strings2 = numbers2.map { "\($0)" } // closure

//
// Filter - selects the elements of an array which satisfy a certain condition.
//

var numbers3 = [1, 2, 3, 4, 5, 6, 7, 8]
var evenNumbers = numbers3.filter { $0 % 2 == 0 } // [2, 4, 6, 8]
var oddNumbers  = numbers3.filter { $0 % 2 == 1 } // [1, 3, 5, 7]

//
// Reduce - combines all the values from an array into a single value.
//

var numbers4 = [1, 2, 3, 4, 5]
var sum = numbers4.reduce(0) { $0 + $1 } // 15

// Note: These are all closures passed in as functions.
