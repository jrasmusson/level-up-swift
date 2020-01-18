/*
  ___     _               _
 | __|_ _| |_ ___ _ _  __(_)___ _ _  ___
 | _|\ \ /  _/ -_) ' \(_-< / _ \ ' \(_-<
 |___/_\_\\__\___|_||_/__/_\___/_||_/__/

 */

/*
 Extensions are how we add new functionality to types. Not just not just classes, structs, enums. But basic types like Int, String, Bool, and Double.
  
 > Note: Extensions can add new functionality to a type, but they cannot override existing functionality.
 */

struct Person {
    let name: String = "Steve"
}

extension Person {
    var address: String {
        return "One Infinite Loop"
    }
}

let steve = Person()
steve.address

// Big advantage here is we don't need access to source code for Person. Can just add new functionality via an extension.

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
let threeFeet = 3.ft

// Methods

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

// Mutating Instance Methods

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square() // someInt is now 9

// Nested Types

// Extensions can add new nested types to exsting classes, structs, and enums.

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

// Initializers

// You can define initializers in extensions.
// - Handy if you want to keep your default struct initializer

struct Point {
    let x: Int
    let y: Int
}

extension Point {
    init(reversed point: Point) {
        x = -point.x
        y = -point.y
    }
}

let positiveXY = Point(x: 1, y: 1) // default
let copiedPoint = Point.init(reversed: positiveXY) // convenient
copiedPoint.x
copiedPoint.y

// Limitations & Gotchas
// - Computed vars only

extension Person {
//    let homeAddress: String = "2101 Waverley Street" // 💥
//    let homeAddress: String { // 💥
//      "2101 Waverley Street"
//    }
    var homeAddress: String { // Must be computed var
        return "2101 Waverley Street"
    }
}

