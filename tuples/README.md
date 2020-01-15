# Tuples

A tuple is a group of zero or more values represented as a single value. For example, if you wanted to combine an HTTP error code with its textual description, a tuple would be really handy for that.

```swift
let error = (404, "Not Found")
```

You could then pass that around, return it from a function, and extract the code either via the tuples index.

```swift
let code = error.0
let description = error.1
```

## Named elements

Or via it’s named element.

```swift
var person = (firstName: "John", lastName: "Smith")

var firstName = person.firstName // John
var lastName = person.lastName // Smith
```

## Creating a tuple

You create a type like any other variable or constant. A tuple literal is a list of values separated by commas between a pair of parentheses. If defined as a variable, you can use the dot notation to change a tuples value.

```swift
var point = (0, 0)

point.0 = 10
point.1 = 15

point // (10, 15)
```

 > Note: Tuples are value types. When you initialize a tuple with another one, you get a copy.

```swift
var origin = (x: 0, y: 0)

var point = origin
point.x = 3
point.y = 5

print(origin) // (0, 0)
print(point) // (3, 5)
```

## Types

Tuples have types. And that type is determined by a tuples values. So `(“tuple”, 1, true)` would be a tuple of type `(String, Int, Bool)`.

If the tuple has only one element, the type of the tuple is the type of the element. `(Int)` is the same as `Int`. This has a strange implication: in Swift every variable or constant is a tuple.

```swift
var number = 123

print(number) // 123
print(number.0) // 123
```

## Empty tuple

`()` is as empty tuple containing no elements. It is also how we represent the `Void` type.

## Decomposing Tuples

Tuples can be decomposed by defining a constant or a variable matching the tuples type, along with a named element. Element names do not have to match.

```swift
let aPerson = (firstN: "John", lastN: "Smith")

let (firstN, lastN) = aPerson // decomposing same named elements
let (first, last) = aPerson   // decomposing different named elements

var (onlyFirstName, _) = aPerson // _ means we don't care
var (_, onlyLastName) = aPerson
```

### for loops

Tuples are return from enumeration of for loops

```swift
let drivers = ["Magnussen", "Raikkonen", "Hamilton", "Verstappen"]

for (index, name) in drivers.enumerated()
{
    print("\(name) has position \(index)")
}
```

## Multiple assignment

You can use tuples to initialize more than one variable on a single line.

Instead of:

```swift
var a = 1
var b = 2
var c = 3
```

You can write

```swift
var (a, b, c) = (1, 2, 3)
```

And you can even mass changes the values of vars like so

```swift
(a, b, c) = (1, 2, 3)
```

## Returning multiple values

Tuples are great for returning multiple values from a single function.

```swift
func split(name: String) -> (firstName: String, lastName: String) {
    let split = name.split(separator: " ")
    return (String(split[0]), String(split[1]))
}

let parts = split(name: "John Smith")
```





### Links that help

- [I heart Swift Tuples](https://www.weheartswift.com/tuples-enums/)
- [Tuples explained](https://learnappmaking.com/tuples-how-to-swift/)

