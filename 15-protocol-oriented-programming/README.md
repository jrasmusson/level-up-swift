# Protocol Oriented Programming (POP)

## What is POP?

POP is a way of sharing code through the mechanics of protocols and extensions while avoiding many of the pitfalls that come with traditional class based inheritance.

```swift
class A {}
class B: A {}

vs

protocol AA {}
extension AA {}
struct BB: AA {}
```

## Pitfalls of class based inheritance?

- Implicit sharing (changing the value in one reference type affects all others)
- Deep fragile object graphs
- Rigid model (children must inherit properties of parent, even if they don't want them)

All this leads a very defensive, rigid, complex, inefficient style of programming where you need to be very careful around what you change, and code very defensive and safely while avoiding more bugs.

## How does POP address this?

Pop address by being a protocol first language. That means it likes definining it's abstractions through protocols, and then implementing details via extensions and implementations.

```swift
// Start with a protocol
protocol AA {} 		// Blue print - what
extension AA {} 	// Default implementation for all instances - how
struct BB: AA {} 	// Custom implementation for that instance - how
```

### An example

Say we want to define an entity with a name and a uuid.

```swift
// Start with a Protocol
protocol Entity {
    var name: String {get set}
    static func uid() -> String
}

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

// Add further requirements by extending existing protocols (Swift version of inheritance)
protocol Persistable: Entity {
    func write(instance: Entity, to filePath: String)
    init?(by uid: String)
}

// Then implement only what you want - the whole thing
struct PersistableEntity: Persistable {
    var name: String
    func write(instance: Entity, to filePath: String) {
    }
    init?(by uid: String) {
        // try to load from the filesystem based on id
        name = "Customer"
    }
}

// Or just a part
struct InMemoryEntity: Entity {
    var name: String
}
```

### Not everything has to be a protocol

Protocol oriented programming looks a little bit different at first. And it is definitely the way Swift likes to work. But you don't have to be religous about it.

By that I mean not everything in your code literally has to start with or be a protocol. A plain old struct is perfectly fine. And then convert to a protocol only when you need it.

Secondly, a lot of libraries we rely on when building apps (i.e. `UIViewController` and UIKit) are class based. Meaning if you need to extend or reuse functionality in a control like a `UIView` go ahead. Don't fight the type system.

Having said that there, are definitly more [protocol oriented ways of working with UIKit](https://developer.apple.com/videos/play/wwdc2016/419/).

Here is an example.

### Working wit UIKit

![TableView](https://github.com/jrasmusson/level-up-swift/blob/master/15-protocol-oriented-programming/images/demo.gif)

The classical OO inheritance way of making the textField and button shake would be to extend `UITextField` and `UIButton` and add the animation code there.

```swift
class BuzzableButton: UIButton {
    func buzz() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

class BuzzableTextField: UITextField {
    func buzz() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
```

The more protocol oriented way of doing it would be to define the protocol `Buzzable`, provide a default implementation, and then have the types inherit the `buzz()` function via the protocol instead.

```swift
protocol Buzzable {} // 1. Define protocol.

extension Buzzable where Self: UIView { // 2. Offer default implementation.
  func buzz() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 5
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
    layer.add(animation, forKey: "position")
  }
}

class BuzzableTextField: UITextField, Buzzable {} // 3. Apply where you like.
class BuzzableButton: UIButton, Buzzable, Fadeable {}
```

Now anything can become buzzable. You don't have to worry about the details of `UITextField` or `UIButton`. And if you want to add another animation, say `fade()` you can do that via another protocol and mixin as you choose.

```swift
protocol Fadeable {}

extension Fadeable where Self: UIView {
    func fade() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.alpha = 1.0 }) { (animationCompleted) in
                        if animationCompleted == true {
                            UIView.animate(withDuration: 0.3,
                                           delay: 2.0,
                                           options: .curveEaseOut,
                                           animations: { self.alpha = 0.0 },
                                           completion: nil)
                        }
        }
    }
}
```

### Links that help

- [WWDC 2015 - Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)
- [WWDC 2015 - Building Better Apps with Value Types in Swift](https://developer.apple.com/videos/play/wwdc2015/414/)
- [WWDC 2016 - Protocol and Value Oriented Programming in UIKit Apps](https://developer.apple.com/videos/play/wwdc2016/419/)
