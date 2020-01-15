# Extensions

Extensions are how we add new functionality to classes, structs, enums, and other protocol types. You can do this on any type - even ones you for which you don't have access to the source code.
 
 Extensions in Swift can add:
 
  - Computed properties
  - Methods
  - New initializers
  - Make an existing type conform to a protocol
 
 > Note: Extensions can add new functionality to a type, but they cannot override existing functionality.
 
## Extension Syntax

```swift
struct SomeType {}

protocol SomeProtocol {}
protocol AnotherProtocol {}

extension SomeType {
    // new functionality to add to SomeType goes here
}

extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```

## Computed Properties

```swift
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
let threeFeet = 3.ft
```

## Methods

```swift
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}
```

## New Initializers

```swift
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
```

## Mutating Instance Methods

```swift
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square() // someInt is now 9
```

## Nested Types

Extensions can add new nested types to exsting classes, structs, and enums.

```swift
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "
```

## Initializers

You can define initializers in extensions. This is handy if you don't want to lose your default struct initializer but also want more convenient ones.

```swift
struct Point {
    let x: Int
    let y: Int
}

extension Point {
    init(reversedFrom point: Point) {
        x = -point.x
        y = -point.y
    }
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

let positiveXY = Point(x: 1, y: 1)
let copiedPoint = Point.init(reversedFrom: positiveXY)

let longForm = Point(x: 1, y: 1)
let shortForm = Point(2, 2)
```
