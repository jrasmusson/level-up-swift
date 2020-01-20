import Foundation
import UIKit

// What is POP

// Intro

/*
 - new way of looking at tradional OO programming
 - instead of traditional inhertiance
  - expensive / unsafe
 - need a way of sharing common code via enums and structs (preferred values types in Swift)
 - POP is Swifts way of doing that
 - by rely on new concepts: protocol extensions, inheritance, composition
 - we get all the speed and safety of immutable data and functional programming with value types
 - why also being able to do inheritiance, shared code resue, in an elegant, performant way
 */

// The problem with classes and traditional inheritiance

// Traditional OO inheritance has some problems

class AA {}
class BB: AA {}

// which suffers from:
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

// same output. same functionality. in a safer, more functional, more efficient way
// value types get stored on the stack
// safer because we get all the immutability that comes with Functional programming types

// Now you may be wondering...
// Why cant structs inherit from each other in Swift?

// struct A {}
// struct B: A {} // Boom!

// Several reasons
// - Performance
// - Safety
// - Can of worms

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

// Here is classical

class Image {
    fileprivate var imageName: String
    fileprivate var imageData: Data

    var name: String {
        return imageName
    }

    init(name: String, data: Data) {
        imageName = name
        imageData = data
    }

    // persistence
    func save(to url: URL) throws {
        try self.imageData.write(to: url)
    }

    convenience init(name: String, contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        self.init(name: name, data: data)
    }

    // compression
    convenience init?(named name: String, data: Data, compressionQuality: Double) {
        guard let image = UIImage.init(data: data) else { return nil }
        guard let jpegData = image.jpegData(compressionQuality: CGFloat(compressionQuality)) else { return nil }
        self.init(name: name, data: jpegData)
    }

    // BASE64 encoding
    var base64Encoded: String {
        return imageData.base64EncodedString()
    }
}

// Test
var image = Image(name: "Pic", data: Data(repeating: 0, count: 100))
print(image.base64Encoded)

do {
    // persist image
    let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
    let imageURL = documentDirectory.appendingPathComponent("MyImage")
    try image.save(to: imageURL)
    print("Image saved successfully to path \(imageURL)")

    // load image from persistence
    _ = try Image.init(name: "MyRestoredImage", contentsOf: imageURL)
    print("Image loaded successfully from path \(imageURL)")
} catch {
    print(error)
}

// So what's the problem? What if you don't need or want all that implementation/coupling/ and dependency?
// what if you only want an image to persist but not encode?

// Redesign using POP

// Start with a protocol

protocol NamedImageData {
    var name: String { get }
    var data: Data { get }
    init(name: String, data: Data)
}

protocol ImageDataPersisting: NamedImageData {
    init(name: String, contentsOf url: URL) throws
    func save(to url: URL) throws
}

// Offer default implementations via extensions

extension ImageDataPersisting {
    init(name: String, contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        self.init(name: name, data: data)
    }

    func save(to url: URL) throws {
        try self.data.write(to: url)
    }
}

// Then make new more specific protocols for only those requirements you like

protocol ImageDataCompressing: NamedImageData {
    func compress(withQuality compressionQuality: Double) -> Self?
}

extension ImageDataCompressing {
    func compress(withQuality compressionQuality: Double) -> Self? {
        guard let uiImage = UIImage.init(data: self.data) else {
            return nil
        }
        guard let jpegData = uiImage.jpegData(compressionQuality: CGFloat(compressionQuality)) else {
            return nil
        }
        return Self(name: self.name, data: jpegData)
    }
}

protocol ImageDataEncoding: NamedImageData {
    var base64Encoded: String { get }
}

extension ImageDataEncoding {
    var base64Encoded: String {
        return self.data.base64EncodedString()
    }
}

// See the difference? What these specific protocols you now have more concrete, clearer code more representative of your design

// You can choose to implement / inherit all the functionality
struct MyImage: ImageDataPersisting, ImageDataCompressing, ImageDataEncoding {
    var name: String
    var data: Data
}

// Or just a few
struct InMemoryImage: NamedImageData, ImageDataCompressing {
    var name: String
    var data: Data
}

// The best part? You can add this functionality without requiring the orignal code.
// We can extend any Foundation or UIKit protocol and decorate it however we choose.

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

protocol Queue {
    var count: Int { get }
    mutating func push(_ element: Int)
    mutating func pop() -> Int
}

// Work through this...
// https://www.bobthedeveloper.io/blog/protocol-oriented-programming-view-in-swift
