# Structs vs Classes

Structs and Classes share a lot of the same space in Swift. They both contain data. They both have methods. And they both fill that role of a place to data and functionality, conveniently in one place. Good old Object-Oriented programming.

Where they differ is intent. Structs are preferred because they are value types. They do everything a classes does, without all the side effects. Because they are passed by copy, you don't need to stress about making a change in one, and having a side-effect in another.

Classes are used for when you need to interoperate with Objective-C - think UIKit. Anytime you need to create a new `UIViewController` or `UITableViewController` you are going to want to reach for a class. But other than that. Favor structs.

The rest of this page explains a few more differences, and goes into greater detail. But the headline is favor structs over classes. And use classes when extending functionality in UIKit.

## Similarities

Both can:

- Define properties to store values
- Define methods to provide functionality
- Define subscripts to provide access to their values using subscript syntax
- Define initializers to set up their initial state
- Be extended to expand their functionality beyond a default implementation
- Conform to protocols to provide standard functionality of a certain kind

## Differences

Classes have additional capabilities that structures don’t have:

- Inheritance enables one class to inherit the characteristics of another.
- Type casting enables you to check and interpret the type of a class instance at runtime.
- Deinitializers enable an instance of a class to free up any resources it has assigned.
- Reference counting allows more than one reference to a class instance.

> Note: You can't inherit with structs - only classes. Structs do inheritance via protocols and extensions.

### Structures get a free member wise initializers

When you define a struct, you get a default initializer for all members for free.

```swift
struct Resolution {
    var width = 0
    var height = 0
}
let vga = Resolution(width: 640, height: 480)
```

> Note: Structs automatically get a so-called memberwise initializer, which is similar to a default initializer, even if you don’t declare default values for the its properties. Default and memberwise initializers are only added if you don’t provide any init() functions yourself. 

## Structures and Enumerations Are Value Types

When you create another instance of a value type (struct and enum) you get a copy.

```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
```

You can change the value of the copy, without affecting the original.

```swift
cinema.width = 2048
```

## Classes are reference types

Not so with classes. When you create another instance of a class, you point to the same instance you were created from (note: no default constructor).

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```

And when you change a property on one, it affects the others.

```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

### Identity Operators

To handle this special classes of checking to see if two instances of a reference type point to the instance of a class, Swift provide two identify operators:

- Identical to (===)
- Not identical to (!==)

Use these operators to check with two reference types refers to the same single instance.

```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
```

> Note: Note that identical to (represented by three equals signs, or ===) doesn’t mean the same thing as equal to (represented by two equals signs, or ==). Identical to means that two constants or variables of class type refer to exactly the same class instance. Equal to means that two instances are considered equal or equivalent in value, for some appropriate meaning of equal, as defined by the type’s designer.

> Note: Treat identity with care. Sharing class instances pervasively throughout an app makes logic errors more likely. You might not anticipate the consequences of changing a heavily shared instance, so it's more work to write such code correctly.

## Choosing Between Structures and Classes

- Use structures by default.
- Use classes when you need Objective-C interoperability.
- Use classes when you need to control the identity of the data you're modeling.
- Use structures along with protocols to adopt behavior by sharing implementations.

### Choose Structures by Default

- Structures are used everywhere in Swift (numbers, strings, arrays, dictionaries)
- Using structures makes it easier to reason about your code (immutability, fewer side-effects)

## Use Classes When you Need Objective-C Interoperability

If you use an Objective-C API that needs to process your data, or you need to fit your data model into an existing class hierarchy defined in an Objective-C framework, you might need to use classes and class inheritance to model your data. For example, many Objective-C frameworks expose classes that you are expected to subclass.

## Use Structures When you Don’t Control Identify

When an external data controls your data, model it with a struct.

```swift
struct PenPalRecord {
    let myID: Int
    var myNickname: String
    var recommendedPenPalID: Int
}

var myRecord = try JSONDecoder().decode(PenPalRecord.self, from: jsonResponse)
```

This way local changes to a PanPalRecord, won’t be accidentally picked up and modified by someone else through a change in myID as it is a constant.

### Use Structures and Protocols to Model Inheritance and Share Behavior

Structures and classes both support a form of inheritance. Structures and protocols can only adopt protocols; they can't inherit from classes. However, the kinds of inheritance hierarchies you can build with class inheritance can be also modeled using protocol inheritance and structures.

If you're building an inheritance relationship from scratch, prefer protocol inheritance. Protocols permit classes, structures, and enumerations to participate in inheritance, while class inheritance is only compatible with other classes. When you're choosing how to model your data, try building the hierarchy of data types using protocol inheritance first, then adopt those protocols in your structures.


### Links that help

- [Swift Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)
- [Choosing Structures](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes)
- [Struct vs Class](https://learnappmaking.com/struct-vs-class-swift-how-to/)
