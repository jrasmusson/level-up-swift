# Functional Programming

Swift embraces a lot of functional programming concepts, and unless you are coming from JavaScript, or have spent a lot of time working with other more functional programming languages, elements of Swift will seem strange and hard to understand.

In this first section, we are going to get you up to speed on

- What functional programming is
- Why it’s important
- How it affects the way your write code in the Swift language

By the end of this section you will know what functional programming is, why so many languages are tilting towards it, along with a heads up in several ways it affects your programming.

## What is functional programming

Functional programming is a programming paradigm, just like Object-Oriented programming (Java, C#), or procedural programming in C.

It’s based on a set of design principles

- Pure functions
- Function composition
- Avoid shared state
- Avoid mutating state
- Avoid side effects

That when applied, make maintaining and working with programs easier to maintain, and contain fewer bugs. That’s the bet.

Take pure functions for example.

## Pure Functions

If you only wrote programs, purely in terms of functions, that in themselves contained no state, you would never have to worry about state or any kinds of sides effects. The very definition of a pure function is

Given the same inputs, always return the same output, and 
Has no side effects

Think of it as pure math. f(x) = x2. That is a function. We can call it given any input. And it will always return the same output. That’s how functional programmers like to write programs. No state pure functions.

```swift
func double(_ value: Int) -> Int {
    return value * 2
}
let doubled = double(2)
```

## Immutability

An immutable object is an object that can’t be modified after it’s created. For us in Swift that is the let statement. In JavaScript it is const. It’s a central concept that is creeping even into Object-Oriented languages because when you can’t change the state of something, you suffer fewer side effects and bugs. If another part of your program can’t accidentally break something, it will never break. Because it’s state can’t change.

That’s why arrays in Swift are passed by value (they are copies) and never by reference (pointer as that would share state). More on value and reference in a bit.

## High Order Functions

When you start to write programs in terms of functions, you tend to reuse the same set of functions over and over again when processing data. Object oriented programming tends to colocate methods and data in to objects. Those colocated methods can only operate on the type of data they were designed to operate on, and often only the data contained in that specific object instance,

In functional programming, any type of data is fair game. The same map() utility can map objects, strings, numbers, or any other data type because it takes a function as an argument (closure) which appropriately handles that given data type. FP pulls off its generic trickery high order functions. And you’ve already played with these in the higher order array functions map, filter, and reduce.

```swift
var numbers = [1, 2, 3, 4, 5, 6]

let oddNumbers = numbers.filter { $0 % 2 == 1 }
let squared = oddNumbers.map{ $0 * $0 }
let summed = squared.reduce(0) { $0 + $1 }
```

## Declarative vs Imperative

Functional programming is a declarative paradigm, meaning the program logic is expressed in the data, not in the control flow.

Imperative programs tell you how something works - if, for loops, while etc.

Declarative programs focus more on the data and tell you what to do.  The how get’s abstracted away.

An example of this is how the for loop.

The **imperative** way to double all the elements in an array would be to loop through, double them, and then returned the doubled result.

The **declarative** way, would be to abstract the flow control away using the higher order array map function, which allows us to more clearly express the flow of data.

```swift
let numbers = [1, 2, 3]

func doubleValue(_ numbers: [Int]) -> [Int] {
    var result = [Int]()
    for number in numbers {
        result.append(number * 2)
    }
    return result
}

let imperative = doubleValue(numbers)    // How

let declarative = numbers.map { $0 * 2 } // What
```

 > **Imperative** code frequently utilizes statements. A statement is a piece of code which performs some action. Examples of commonly used statements include _for_, _if_, _switch_, _throw_, etc.

> **Declarative** code relies more on expressions. An **expression** is a piece of code which evaluates to some value. Expressions are usually some combination of function calls, values, and operators which are evaluated to produce the resulting value.

These are all examples of expressions.

```swift
2 * 2
Array.map { $0 * 2)
Array.filter { $0 % 2 == 1 } 
```

## What does it all mean?

What this all means for you, the up and coming Swift programming coming from an Object-Oriented background, is that you will see a different style of code when programming in Swift. One that

- Favors immutability
  - _let_ over _var_
  - Structs & Enums over Classes
- Leverages Higher Order Functions (map, filter, reduce)
- Uses both Declarative over Imperative style programming (SwiftUI over UIKit)
- Prefers passing data by value instead of by reference

### Links that help

- [Functional Programming Explained](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
