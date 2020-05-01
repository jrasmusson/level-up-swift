# Enumerations

An enumeration (_enum_) is common type for a group of related values that enables you to work with values in a type-safe way. If you are familiar with C, you will know C enumerations assign names to integers. Enumerations in Swift more flexible - you don’t have to provide a value.

```swift
enum SomeEnumeration {
    // enumeration definition goes here
}
```

Here’s an example for the four main points of a compass:

```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}
```

 > Note: Swift enums don’t have integer values set by default. In example above north, south, east, west don’t implicitly equal 0 ,1 ,2 ,3. Instead these enumeration cases are values in their own right of type _CompassPoint_.

Can define on a single line.

```swift
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

 > Enums by convention are singular (not plural).

You can assign them to variables.

```swift
var directionToHead = CompassPoint.west
```

And then can infer type.

```swift
directionToHead = .east
```

## Matching values with Switch Statement

In Swift we match enumeration values with the _switch_ statement.

```swift
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```

A Swift _switch_ statement must be exhaustive. This prevents bugs and ensures cases aren’t missed. If you don’t need every case covered use can assign a _default_ one to catch cases not covered explicitly.

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```

## Associated Values

Sometimes it is convenient to values to enum cases. These are called _associated values_.

```swift
enum Barcode {
    case upc(Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
```

And then you can use or unpack the associated values like this.

```swift
switch productBarcode {
case .upc(let numberSystem):
    print("UPC: \(numberSystem)")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

### Associated Values as Tuples

Associated values in enums are tuples. Tuples are an ‘on the fly’ data structure where you can group a collection of variables together.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```


They way to read this is

> “Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”

The associated type with the upc barcode is (Int, Int, Int, Int). That’s the tuple. That’s the type.

In our case it is also the associated value with the enum. I personally don’t like this way of defining associated types with enums, because I don’t know what all those ints actually mean. 

I would rather write it like this.

```swift
enum BarcodeWithNamedParams {
    case upc(numberSystem: Int, manufacturer: Int, product: Int, check: Int)
    case qrCode(productCode: String)
}
```


## Raw Values

An alternative to _associated values_ are _raw values_. Raw values can be:

 - String
 - Character
 - Int 
 - Floating-point type


```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

These raw values are defined as type _Character_ and can be assigned _Character_ values. 

Raw values can be
Strings
Characters
Ints
Floating point (float, double)

 > Note: One difference between associated values and raw values is that associated values for an enum can change while raw values can’t.

### Implicitly Assigned Raw Values

When working with raw values, you don’t need to explicitly assign for every case. Swift will assign for you.

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

Or

```swift
enum CompassPoint: String {
    case north, south, east, west
}
```

Which you can then access as

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"
```

## Enums & Protocol

Enums can gain a lot of extra functionality by implementing various _protocols_. Here are some examples.

### Indexed Enum as String

- `CustomStringConvertible` is for when you want a special String representation for your _enum_. 
- `CaseIterable` is for when you want an iterator for all your _enum_ cases.

```swift
enum Category: Int, CustomStringConvertible, CaseIterable {
    case games = 0
    case music
    case movies
    case books
    case hotels
    case cars
    case shopping
    case restuarants

    var description : String {
      switch self {
      case .games: return "Games"
      case .music: return "Music"
      case .movies: return "Movies"
      case .books: return "Books"
      case .hotels: return "Hotels"
      case .cars: return "Cars"
      case .shopping: return "Shopping"
      case .restuarants: return "Restuarants"
        }
    }
}

var tabTiles: [TabView] {
    Category.allCases.map {
        let tabView = TabView()
        tabView.label.text = $0.description
        return tabView
    }
}
```


### Links that help

- [Swift Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)

