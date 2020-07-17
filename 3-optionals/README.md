# Swift Optionals

## What is a Swift Optional?

Optional is a type in the Swift language that indicates a variable may or may not have a value. For example if we know a constant will have a value of 42, we can immediately assign it that value like this.

```swift
let number = Int(42)
```

But if, at runtime, we aren’t yet sure what value _number_ is going to be, we can assign it an _Optional_ value like this.

```swift
let number: Int?
```

Think of optional as a wrapper. It’s like a gift box which wraps the value inside, and like a real-life box, _Optional_ can either contain something, or be empty.

![](images/example2.png)

## Why do we need them?

Optionals are Swift’s way of dealing with something that has plagued the computing language for decades. How to deal with values that are _nil_ or _null_.

In most computer languages, anytime you try to access _null_ or _nil_ your computer program blows up. But in Swift, the compiler helps you by making the checking of _nil_ or _null_ explicit (thereby minimizing errors).

For example, here is an example of how Swift handles trying to convert a string into a number of type _Int_.

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"
```

Instead of taking the string “123” and either throwing an error or blowing up because it wasn’t able to convert, Swift instead returns an _Optional_ _Int?_, and then leaves it up to you to unwrap it and check after to see if it contains a real value.

The advantages of this are 

- safety - we can a compile time check telling us whether we are dealing with a variable that may or may not be _nil
- less cumbersome error handling - instead of having to surround everything with a _try_ catch our variable and program can continue processing (resulting in less code)
- ease of maintenance and simplicity - because there is less code, it’s easier to reason about and maintain

So that’s what Optionals are and why we use them. Now let’s look at some of the different ways we can go about unwrapping them.

## How to unwrap Optionals

![](images/unwrapping.png)

There are two ways we generally unwrap Optionals. We can unwrap them nicely using the question mark (Optional binding, Nil-Coalescing, Option Chaining). Or we can force an unwrap hard with an exclamation mark.

The former is recommended because if there is no underlying value, we simply get an _Optional_ and our program continues running. If we force an unwrap (!), and no underlying value is there, or program blows up 💥and we get a runtime error. Let’s see how each of these work now. 


### Optional Binding

The nice way to unwrap an Optional in Swift is to use an _if_, _guard_, or _switch_ statement.

```swift
let possibleNumber: Int? = 42

if let number = possibleNumber {
      //  Int 42
} else {
     // nil
}
```

_if let_ unwraps the _Optional_, pulls it out of the gift box, and returns a plain old _Int_. That _Int_ is then available within the_true_ scope of the if statement. And if the _Optional_ was _nil, we would be redirected to the _false_.

You can also wrap Optionals with _guard_s.

```swift
func printNumber(possibleNumber: Int?) {

    guard let number = possibleNumber else {
        print("nil")
        return
    }

    // 42
}
```

_guard_s work the same way only in reverse. Instead of getting the unwrapped variable in the _if_, _guard_ unwraps it and makes the value available for the scope of the entire method.

### Unwrap with the same name

The convention in Swift isn't to preface your variable names with the word _possible_ for optionals. This was just done for demonstrative purposes. The more proper way is to use the same name as the optional passed in. For example this, while initially confusing, is totally fine for unwrapping.

```swift
func printNumber(number: Int?) {

    guard let number = number else {
        print("nil")
        return
    }

    // 42
}
```

This unwraps `number` the optional, and creates a new constant (of type Int) unwrapped and ready for use.

### Forced Unwrapping

Forced unwrapping (!), or Unconditional Unwrapping, is where you take an _Optional_ and extract it’s contents no matter what. If there is an underlying value you are fine (it gets assigned the variable). If there is no value your program blows up. Game over.

```swift
let possibleNumber: Int? = 42
let number = possibleNumber // Yay ✅

let possibleNumber: Int?
let number = possibleNumber! // Boom 💥
```

If you know you are going to have a value, you can force unwrap in your expression, and then continue using all in one line.

```swift
let isPNG = imagePaths["star"]!.hasSuffix(".png")
print(isPNG)
// Prints "true"
```

### Using the Nil-Coalescing Operator

Nil-Coalescing Operators are how we assign values to expression in the event our _Optional_ is _nil_. 

For example, say we have a _Optional_ constant _nickName_, that may or may not have a value by the time we come around to processing it. If the value of _nickName_ is _nil, we can replace, or substitute in, another value in it’s place and continue processing. All in one line.

```swift
let nickName: String? = nil
let defaultName: String = "John"
let informalGreeting = "Hi \(nickName ?? defaultName)"
```

What this is basically doing is unwrapping _nickName_, seeing if it has an underlying value, using it if it does, and swapping in another variable if it does not.

Nil-coalesers are convenient ways to swap in default values if values for Optionals aren’t there. They are completely safe and handy for inlining default value.

### Optional Chaining

Optional chaining is an alternative to forced unwrapping that fails in an elegant way. Optional chaining does the same thing as force unwrapping, but instead of failing in the event of there being no value, it simply returns wrapped Optional that lets us continue processing.

This example shows the difference. Here we have two classes. One called _Person_ and _Residence_:

```swift
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}
```

If we create a new _Person_ instance, it’s _residence_ property defaults to an _Optional_ value of _nil_ because we assigned it no value to it. 

```swift
let john = Person()
```

If we force unwrap (!) that persons _residence_, it will trigger a runtime error.

```swift
let roomCount = john.residence!.numberOfRooms // runtime error Boom 💥
```

Optional chaining provides us an alternative. Instead of unwrapping and blowing up in the event of a _nil_ value, Option Chaining returns an unwrapped _Optional_, and forces you to check using regular Optional binding to see whether it has an underlying value or not.

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."
```

Note: There is a very subtle thing going on here. Even though _numberOfRooms_ is a hard _Int_, an optional gets returned from this expression.

```swift
let roomCount = john.residence?.numberOfRooms // This is an Optional
```

So beware that when you are accessing Optionals as part of an Optional Chain, the value you get back will be of type _Int?_ and not _Int_ as you might expect.

### Mechanics

Know that there are several different ways Optionals can be represented.

```swift
let shortForm: Int? = Int("42")
let longForm: Optional<Int> = Int("42")
let number: Int? = Optional.some(42) // `some` is the Optional Enum type for value
let noNumber: Int? = Optional.none // `none` is the Enum type for no value
```

Under the hood a Swift Option is just an `enum`.

```swift
enum Optional<T> {
   case none
   case some<T>
}
```

And if you go look at the source code for how Optionals are implemented, you will see it is just a switch statement tied to this enum.

```swift
extension Optional: CustomDebugStringConvertible {
  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    switch self {
    case .some(let value):
      var result = "Optional("
      debugPrint(value, terminator: "", to: &result)
      result += ")"
      return result
    case .none:
      return "nil"
    }
  }
}
```

## How to use

### Favor concrete types

Swift Optionals are great and all, but remember. Your program will be easier to reason about, and simpler, if all your variables have data. So don't use Optionals just because. Save them for those instances where you really need them, because they do in cost override in terms of maintenance and management.

If you can assign a variable a value, always pick that over the Optional. Optionals force you to deal with the optionality of a variable. So if you use optionals everywhere you are going to have a lot of boiler plate code that looks like this:

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

if let address = john.residence?.address {
    print("John's address is \(address) room(s).")
} else {
    print("Unable to retrieve address.")
}
```
as opposed to this:

```swift
let roomCount = john.residence.numberOfRooms
let address = john.residence.address
```

If our `residence` property doesn't have to be an Optional, the code is much easier to read without.

## Unwrap early

If you do have an Optional, unwrap with a guard as soon as you can.

```swift
guard let roomCount = john.residence?.numberOfRooms else {
    return
}

// free to use roomCount as an Int
```

The nice thing about guards is they make Optionals concrete. They unwrap them. Doing that near the beginning of your method makes that varible concrete, and removes the Optionality of the variable early on in your program. Thus making things easier to reason about.


### Summary

Optionals are Swift type that indicates a variable may or may not have a value. 

Four ways of unwrapping them:

- Optional binding	
- Force unwrapping
- Nil-Coalescing
- Optional Chaining

Use them only when you need them (favor concrete types). And remember they are nothing more than enums under the hood. So don't be intimidated by them 🚀. 

### Links that help

- [Apple Docs Optional](https://developer.apple.com/documentation/swift/optional)
- [Apple Swift Documentation](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
- [Apple Option Chaining](https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html)
- [How to browse Swift source code](https://useyourloaf.com/blog/exploring-the-swift-standard-library-source-code/)
