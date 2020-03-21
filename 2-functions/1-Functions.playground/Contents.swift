//
// Functions
//

func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

// - Ready Player 1 🕹
//
//   Remove the `day` parameter. Add a parameter to include today’s lunch
//   special in the greeting.
//

// Omitting the prefix

func greet(_ person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", day: "Wednesday")


// Argument Labels and Parameter Names

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
    // return for one liners optional
}
greet(person: "Bill", from: "Cupertino")

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)

func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}




// - Ready Player 1 🕹
//
// Add an argument label of `to` to the `person` parameter name,
// and update the `greet` method accordingly.

// Default Parameter Values

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
