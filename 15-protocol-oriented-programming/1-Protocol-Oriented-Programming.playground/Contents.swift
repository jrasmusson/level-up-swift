import Foundation
import UIKit

// What is POP

// Intro

/*
 - new way of looking at tradional OO programming
 - instead of reling on traditional inhertiance for reuse
 - Swift relies more heavily on protocols and extensions
  - this avoids many of the pitfalls that come with traditional OO
  - is safer because avoids mutability
  - more performant because value semantics are used over reference
  - lets dive deeper and see how it works
 */

// The problem with classes
// - implicit sharing

class AA {}
class BB: AA {}

// which causes us to:

/*
 Defensive copying
 Inefficiency
 Expense
 Race conditions
 Locks
 More inefficiency tracking locks
 Deadlock
 Complexity
 Bugs!
 */

// And you can see examples of this in Cocoa

// We can do it, just not that great

// What is POP

// POP is how Swift does classical OO inheritance in a performance safe way

// We start by defining a protocol

protocol Foo {}
protocol Bar{}

// we then implement in enums or structs
struct Baz: Foo, Bar {}

// and we extend and resuse via extensions
extension Foo {
    func handle() {}
}

// That's it!

// same output. same functionality. in a safer, more functional, more efficient way
// value types get stored on the stack
// safer because we get all the immutability that comes with Functional programming types

// Now you may be wondering...
// Why cant structs inherit from each other in Swift?

// struct A {}
// struct B: A {} // Boom!

// Several reasons
// - Performance - structs and enums can be better optimized and inlined by the compiler
// - Safety - you can't mess up your parent by messing with your children (invariants)
// - Can of worms - gets complicated...

// https://forums.swift.org/t/why-cant-structs-inherit-from-other-structs/3647/2

// Examples

// Say we need a type called Entity that was want all types to conform to. Start with a protocol.

// Start with a Protocol

protocol Entity {
    var name: String {get set}
    static func uid() -> String
}

// What if we want to define a default implementation? Can't / don't want inheritance.
// Provide default implementation (that all conforming implementations will inherit) via extension

// Provide default implementation via extensions

extension Entity {
    static func uid() -> String {
        return UUID().uuidString
    }
}

// that everyone gets

struct Order: Entity {
    var name: String
    let uid: String = Order.uid()
}
let order = Order(name: "My Order")
print(order.uid)

// And further requirements via inheritance

protocol Persistable: Entity {
    func write(instance: Entity, to filePath: String)
    init?(by uid: String)
}

// Protocols can inherit other protocols and add further requirements on top of the ones they already inherit

// Types that implement the Perishable protocol must conform to Perishable and Entity

struct PersistableEntity: Persistable {
    var name: String
    func write(instance: Entity, to filePath: String) {
    }
    init?(by uid: String) {
        // try to load from the filesystem based on id
        name = "Customer"
    }
}

// But implement only those protocols you need for specific types

struct InMemoryEntity: Entity {
    var name: String
}

// This is powerful! Allows for more granular and flexible designs. Enabling you to compose new entities based on only requirements you need and like.

struct MyEntity: Entity, Equatable, CustomStringConvertible {
    var name: String
    // Equatable
    public static func ==(lhs: MyEntity, rhs: MyEntity) -> Bool {
        return lhs.name == rhs.name
    }
    // CustomStringConvertible
    public var description: String {
        return "MyEntity: \(name)"
    }
}
let entity1 = MyEntity(name: "42")
print(entity1)
let entity2 = MyEntity(name: "42")
assert(entity1 == entity2, "Entities shall be equal")


// Comparing Classical with POP



// Summary

// Swift supports both traditioal OO and Protocol Oriented Programming.
// You are free to choose. Just beaware and start getting comfortable with POP.
// Looks of advantages. Cleaner design. The Swift Way.

// Note: You don't literally need to make everythiung a protocol. Start with structs and enuma and
// implement protocols when you need them.

// But as soon as you feel you need to share implementation across multiple types, think POP.

// Links
// https://developer.apple.com/videos/play/wwdc2015/408/
// https://developer.apple.com/videos/play/wwdc2015/414/
// https://developer.apple.com/videos/play/wwdc2016/419/

// Examples
// https://www.pluralsight.com/guides/protocol-oriented-programming-in-swift


// Arcade

// Work through this...
// https://www.bobthedeveloper.io/blog/protocol-oriented-programming-view-in-swift
