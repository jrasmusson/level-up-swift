# What is a closure?

Closures are self-contained blocks of functionality that can be passed around and used in your code. 

- Similar to blocks in C and lambdas in other programming languages.
- Can capture and store references to any constants and variables from the context in which they are defined. Known as closing _over_. Swift handles all of the memory management of capturing for you.

Functions are actually special cases of closures. Closures take one of three forms:

- Global functions are closures that have a name and do not capture any values.
- Nested functions are closures that have a name and can capture values from their enclosing function.
- Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

Swift closures encourage clean, clear, clutter free optimizations that make code easier to read. These optimizations include:

- Inferring parameter and return value types
- Implicit returns from single-expression closures
- Shorthand argument names
- Trailing closure syntax.

## Closure Expressions

Closure expressions are a way to write inline closures in a brief, focused, syntax, without requiring a full declaration and name.

### The Sorted Method

Swifts standard library provides a method called _sorted(by:)_ which sorts an array of values of a known type. Once it completes it returns a new sorted array.

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
```

The _sorted(by:)_ method accepts a closure that takes two arguments of the same type as the array’s contents and returns a _Bool_ value to say whether the first value should appear before or after the second.

```swift
(String, String) -> Bool
```

One way…

```swift
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)
```

But this is long winded. A better way is as follows.

### Closure Expression Syntax 

Closure expression syntax has the following general form:

<img src="https://github.com/jrasmusson/level-up-swift/blob/master/4-closures/images/closure.png" alt="drawing" width="400"/>


And you can inline closures into functions and methods like this.

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```


Here the signature is the same, but the parameters and return type are written _inside_ the curly braces.
Start of closure is introduced by the _in_ keyword.
This keyword indicates that the definition of the closure’s parameters and return type have finished, and the body of the closure is about to begin.
Because body is short can condenced into one line

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```
### Inferring Type From Context

Because sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns. The _sorted(by:)_ method is called on an array of strings, so its argument must be of function of type _(String, String) -> Bool_. That means the _(String, String)_ and _Bool_ types do not need to be written as a part of the closure expressions’s definition. Because all the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted.

```swift
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
```

It is always possible to infer the parameter types and return type when passing a closure to a function or method as an inline closure expression. As a result, you never need to write an inline close in its fullest form when the closure is used as a function or method argument.

Nonetheless, you can still make the types explicit if you wish, and doing so is encouraged if it avoids ambiguity for readers of your code.

### Implicit Returns from Single-Expression Closures

Single-expression closures can implicitly return the result of their single expression by omitting the _return_ keyword.

```swift
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
```
### Shorthand Argument Names

Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.

```swift
reversedNames = names.sorted(by: { $0 > $1 } )
```

If you use these shorthand argument names, you can omit the closure’s arguments list from its definition, and the number and type of the shorthand argument will be inferred from the expected function type. The _in_ keyword can also be omitted, because the close expression is made up entirely of its body.

Here $0 $1 refer to the closure’s first and second _String_ arguments.

### Operator Methods

There’s actually an even shorter way to write the closure expression above. Swift’s _String_ type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type _String_, and returns a value of type _Bool_. Which just happens to perfectly fit our closure definition. Therefore we can simply pass in the greater-than operator, and Swift will infer that you want to use it’s string-specific implementation.

```swift
reversedNames = names.sorted(by: >)
```


## Trailing Closures

If you need to pass a closure to a function as the functionals final argument and the closure express is long, it can be useful to write it as a trailing closure instead. A trailing closure is written after the function’s call’s parenthese, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.

Here is a closure that take no input and returns no outputs - pure body.

```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:
// Here we move the parameters inside

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:
// here we drop the label and move everything inside - trailing closure

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```

The sorted method from the previous section can be written as a trailing closure like this.

```swift
reversedNames = names.sorted() { $0 > $1 }
```
## Capturing Values

A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.

In Swift, the simplest form of a closure that can capture values is a nested function. Nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

Here the nested function incrementer captures runningTotal and amount from the surrounding context. And when you run it increments each time.

```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() // 10
incrementByTen() // 20
incrementByTen() // 30
```
## Closures Are Reference Types

Whenever you assign a function or a closure to a constant, you are actually setting that constant to be a reference to the function or closure.

That means if you assign a closure to two different variables, both will refer to the same closure.

```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50

incrementByTen()
// returns a value of 60
```

## Escaping Closures

All the closures we have been looking at so far have been non-escaping. Non-escaping means they are executed immediately in the method they are passed to. But what if we want our closure to execute after that method returns. And have it still have access to all the scope and data when it runs? (i.e. asynchronous network calls).

For that we have @escaping closures. 

> Escaping closures outlive the functions they are passed to.

- An *escaping closure* is a closure that’s called _after_ the function is was passed to returns. In other worids, it _outlives_ the function it was passed to.
- A *non-escaping closure* is one called _within_ the function is was passed into before it returns.

### Closures are non-escaping by default

Closures are non escaping by default. Meaning if you want your closure to remain, you have to be explicit about it and include the `@escaping` keyword. Closures were made non escaping by default for safety (non-escaping closures can’t create retain cycles) and speed (compiler can optimize non-escaping closures better because they don’t strongly reference objects). The compiler doesn’t need to store these objects in a way that allows it to access them later.

In this example, dispatching off the main UI thread ensures the closure will be retained and executed _after_ the method completes. Hense the need for `@escaping`.

```swift
import Foundation

// non-escaping (default) - nothing retained, closure executes immediately
func macICanBuy(budget: Int, closure: @escaping (String) -> Void) {
    closure("Big Mac")
}

// escaping - closure retained, @escaping makes explicit
func macICanBuy(budget: Int, closure: @escaping (String) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        closure("Big Mac")
    })
}

macICanBuy(budget: 100, closure: { mac in
    print("I can afford a \(mac)")
})
```

### The Risks of Wrongly Escaping Closures

If you are not careful with escaping closures you can get these things called retain cycles. Retain cycles are where your closure has a strong reference to an object it references (often self) and self has a reference to the underlying closure. They point to each other. And neither is willing to let go resulting in a memory leak.

We break this retain cyle in escaping closures by leveraging a `capture list`. This explicitly tells the closure to weakly hold onto either `self` (most common) or any other object you don't want it to keep a strong reference to.

```swift
{ [weak airmail] (apples) -> Void in
    // Send apples
}
```

Here is an example for self.

```swift
UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { [weak self] (settings) in
    let status = NotificationManager.systemPromptStatusFromSettings(settings)
    self?.operatingSystemPromptStatus = status
    completion(status)
})
```

#### Strong Reference & Capture Lists

When you see a capture list like this, what it is really saying is something was strongly captured outside the closure, and we are making it weakly available within the closure to avoid a memory leak.

```swift
[weak database] 
 ```
A capture list is a comma-separated list of variable names, prepended with weak or unowned, and wrapped in square brackets. Some examples:

```swift
[weak self]
[unowned navigationController]
[unowned self, weak database]
```

You use a capture list to specify that a particular captured value needs to be referenced as `weak` or `unowned`. Both `weak` and `unowned` break the strong reference cycle, so the closure won’t hold on to the captured object.

Here’s what they mean:

- The `weak` keyword indicates that the captured value can become `nil`
- The `unowned` keyword indicates that the captured value never becomes `nil`
- Both `weak` and `unowned` are the opposite of a strong reference, with the difference that weak indicates a variable that can become `nil` at some point.

You typically use `unowned` when the closure and the captured value will always refer to each other, and will always be deallocated at the same time. An example is `[unowned self]` in a view controller, where the closure will never outlive the view controller.

You typically use `weak` when the captured value at some point becomes nil. This can happen when the closure outlives the context it was created in, such as a view controller that’s deallocated before a lengthy task is completed. As a result, the captured value is an optional.

The concept of capturing, capture lists and memory management is tricky. It’s not that complicated, but I think it’s just hard to visualize such an abstract concept. In practical iOS development, the most common capture list is `[weak self]` or `[unowned self]`.

Good explaination [here](https://learnappmaking.com/closures-swift-how-to/#strong-references-capture-lists).

## Autoclosures

An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. 

This syntactic sugar lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.

It is common to call functions that take autoclosures, but it’s not common to implement that kind of function.

An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.

Basically it is this

```swift
let customerProvider = { customersInLine.remove(at: 0) }
```

It is a closure that is automatically created so it can be stored and executed at a later date.
It wraps a body of code, assigns it to a variable, and when it’s called it return the value of the expression wrapped inside it.

You call these things. But you don’t really implement them. But they are handy for delaying execution or selectively executing things that are computationally expensive.

```swift
func someCondition() -> Bool { return false }

assert({ someCondition() }, { "Hey, it failed!" })  // without

func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {
    guard isDebug else {
        return
    }

    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
}

assert(someCondition(), "Hey it failed!")           // with
```

## Map Filter Reduce

Map filter and reduce are Higher Order array functions in Swift that take closures and perform high level operations.

 A higher order function is a function that does at least one of the following:
 
 - takes a function as an input
 - returns a function as the output

Swift has three important higher order functions implemented for arrays:
 map, filter and reduce.

```swift
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

//
// Map - apply same operation to each element in collection
//

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
```


### Links that help

- [Swift Closure](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)
- [Autoclosure Sundell](https://www.swiftbysundell.com/articles/using-autoclosure-when-designing-swift-apis/)
- [Map/Filter/Reduce Use Your Loaf](https://useyourloaf.com/blog/swift-guide-to-map-filter-reduce/)
- [Learn App Making](https://learnappmaking.com/escaping-closures-swift/)
- [What is escaping closure](https://fluffy.es/what-is-escaping-closure/)











