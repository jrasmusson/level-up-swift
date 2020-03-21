//
// Advanced: Function Types
//

// Every function has a specific type, made up of the parameter types and the return type of the function.

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

// The type of both of these functions is (Int, Int) -> Int. This can be read as:

//  “A function that has two parameters, both of type Int, and that returns a value of type Int.”

// Here’s another example, for a function with no parameters or return value:

func printHelloWorld() {
    print("hello, world")
}

// Note: The type of this function is () -> Void,
//       or “a function that has no parameters, and returns Void.”
//       Which means even through there is no return, the return type is still of type void.

// Using Function Types

// Functions can be assigned types.

var mathFunction: (Int, Int) -> Int = addTwoInts

// Functions as parameters

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

// - Ready Player 1 🕹
//
//   Write a function for above matchers ther returns true if any numbers are between 1 and 10 (inclusive).
//
//   [20, 19, 7, 12] => true because of the 7
//   [20, 19, 12]    => false

//
// Links that help
//
// - https://docs.swift.org/swift-book/LanguageGuide/Functions.html
