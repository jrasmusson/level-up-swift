/*
  ___         _               _
 | _ \_ _ ___| |_ ___  __ ___| |___
 |  _/ '_/ _ \  _/ _ \/ _/ _ \ (_-<
 |_| |_| \___/\__\___/\__\___/_/__/
 
 */

// Protocols are like interfaces. When you conform to a protocol, you are saying this class, struct, or enum will do whatever this protcol defines. They are how we add functionality to types in Swift.

// You define them like this

protocol SomeProtocol {
    func doSomething()
}

protocol AnotherProtocol {
    func doSomethingElse()
}

// And then you implement them like this - on the class, struct, or enum

struct SomeStructure: SomeProtocol {
    func doSomething() {
        // code
    }
}

// or via an extension

extension SomeStructure: AnotherProtocol {
    func doSomethingElse() {
        // code
    }
}

//
// Properties
//
// - Can be implemented as stored or computed (but must be vars)
// - Need to say whether gettable or settable

protocol Clickable {
    var didClick: Bool { get }
    var numberOfClicks: Int { get }
 // let numberOfClicks: Int { get set } // 💥
}

// Stored properites
struct Button: Clickable {
    var didClick: Bool = true
    var numberOfClicks: Int = 4
}

// Must be computed if in extension
struct Link {}
extension Link: Clickable {
    var didClick: Bool {
        return true
    }

    var numberOfClicks: Int {
        get {
            return 4
        }
    }
}

//
// Methods
//
// - Supports methods (just no default values)
//
protocol RandomNumberGenerator {
    func random() -> Double
}

class SimpleGenerator: RandomNumberGenerator {
    func random() -> Double {
        return 42 // Not very random :)
    }
}

// Mutating Methods

// If a protocol needs to mutate the instance it belongs to add the `mutating` keyword.
// > Note: Not required for class. Only for structs and enums.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

// Protocols enable polymorphism.

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: SimpleGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

// Add Protocol Conformance with an Extension
// - If you already conform to a protocols implementation, but want to conform to its type, you can do so by adding a marker an extension.

protocol Growable {
    var age: Int { get }
}

class Hobbit {
    var age = 111
}

extension Hobbit: Growable {}

// Protocol Composition - you can combine protocols for enforcement

func printAgeOfHobbit(growableHobbit: Hobbit & Growable) {
    print(growableHobbit.age)
}

// Checks for protocol conformance

let bilbo = Hobbit()
let isGrowable = bilbo is Growable // true if conforms to protocol

class Dwarf {}
class MountainDwarf: Dwarf {}

let gimli = MountainDwarf()

let aDwarf = gimli as? Dwarf // downcasts gimil > Dwarf
let notADwarf = bilbo as? Dwarf // nil
