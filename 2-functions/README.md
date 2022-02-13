# Functions

Functions look different in Swift when compared to other languages. But they have some very nice features that enable you to write really clear, concise, expressive code. Let’s take a look now at what makes functions so special in Swift, and some of their more unique properties.

## Named Parameters

Named parameters are what we call the descriptors used to describe the names of variables defining our functions.

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
```

This method has two named parameters - `person` and `day`. And you invoke methods in Swift by prefixing them in front of method values like this.

```swift
greet(person: "Bob", day: "Tuesday")
```

Knowing what this is called, `named parameter` is handy. Because another thing that Swift allows you to do is declare another type of label descriptor to make your methods even more expressive. Something called an argument label.

## Argument Labels

```swift
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
```

See that word `from` in front of the named label `hometown`? That is called an argument label. Argument labels are labels that you use when calling a function:

```swift
greet(person: "Bill", from: "Cupertino")
```

But it is the named labels that are used within the function itself when processing. This can be confusing at first (not really knowing which label or parameter name to use and where). But having this option leads to some really nice expressive coding options. 

```swift
func greet(visitor person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
greet(visitor: "Bill", from: "Cupertino")
```

And to help you remember the names of these things just remember this.

```swift
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}
```

## Omitting Argument Labels

If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
```

If a parameter has an argument label, the argument must be labeled when you call the function.

## Default Parameter Values

```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault:
```

## Variadic Parameters

A *variadic parameter* accepts zero or more values of a specified type. Means that the parameter can be passed a varying number of input values when the function is called. Write by inserting three period characters (...) after the parameter’s type name.

The values pass are made available within the function body as an array of the appropriate type. For example a parameter with the name *numbers* and a type `Double…` is made available within the function’s body as a constant array.

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
```

> Note 
> A function may have at most one variadic parameter.


# Functions Types

Every function in Swift has a _function type_, made up of the parameter types and the return type of the function.

```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
```

These two functions two two _Int_ values, and return an _Int_ value. The type of both of these values is `(Int, Int) -> Int`. 

Even functions that have no input views, and no return type have a type.

```swift
func printHelloWorld() {
    print("hello, world")
}
```

The type of this function is `() -> Void`.

## Using Function Types

You use function types just like any other types in Swift. For example you can create a function type, assign it to a variable, and then save or invoke it later like this:

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
…
print("Result: \(mathFunction(2, 3))")
```

## Function Types as Parameter Types

You can use function types such as _(Int, Int) -> Int_ as a parameter type for another function.

```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```

## Function Types as Return Types

You can use a function type as a return type of another function. You do this by writing a complete function type immediately after the return arrow (->) of the returning function.

Here are two simple functions each with type _(Int) -> Int_.

```swift
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
```

And here is a function called `chooseStepFunction(backward:), whose return type is _(Int) -> Int_. And it returns either the _stepForward_ or _stepBackward_ function based on the Boolean parameter passed in.

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
```

And to step backward, or count down to zero, you could do something like this:

```swift
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!
```

Here we are setting up a conditional around `currentValue > 0`, passing that into our _chooseStepFunction_, and then taking the returned function and executing it (which in turn decrements the counter) and lowers the _currentValue_ again.

This is confusing! But cool. We are basically returning functions, executing them, storing the returned value of the executed function, and the using the result to repeat the process over and over again until _currentValue != 0_.

## Nested Functions

You can nest functions in Swift. Another way to do the above count backwards logic would be to nest or embed the _stepForward_, _stepBackward_ functions within the _chooseStepFunction_ like this.

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```

## Functions as variables

Functions can be instantiated and passed around like any other variable. This can be handy in testing (no need to mock an object in it's entirety) or flexible API that take a _func_ instead of classes, structs, and enums.

Here for example we define a _Math_ struct with a func called _addTwoInts_. Think of this func definition just like any other Swift _var_ or _let_. 

```swift
import UIKit

struct Math {

    // think of this as a variable
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    // just like any other var or let
    var name = "Math 101"
}
```

We can then define it as a variable type in a class. And change it's value.

```swift
struct Calculator {
    var mathFunction: (Int, Int) -> Int = Math().addTwoInts
}

var calc = Calculator()
calc.mathFunction = Math().subTwoInts
```

Or we can use it as an argument and pass it to other functions.

```swift
struct Command {

    func execute(twoIntEquation: (Int, Int) -> Int) {
        let answer = twoIntEquation(1, 2)
        print("\(answer)")
    }
}

let command = Command()
command.execute(twoIntEquation: Math().addTwoInts(_:_:))
```

If your func expression is complicated use a `typealias`.

```swift
struct Calculator {
    typealias expression = (Int, Int) -> Int
    var mathFunction: expression = Math().addTwoInts
}
```

### Links that help

- [Swift Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)


