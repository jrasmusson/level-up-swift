# Protocol Based Inheritance

Classic OO inheritance is still provides for classes in Swift, but the preferred way to add new functionality is via protocols and extensions instead.

In this section you are going to learn the Swift way of adding new functional to objects, and see why composing functionality instead of inheriting it is the preferred way to share functionality and elegantly reuse code.

## Inheritance via Protocols & Extensions

Classical OO inheritance has served us well for over 40 years in software, but it suffers two things
A lack of flexibility
A fragile inheritance structure

What’s gained more popularity in recent years is composing behavior into new objects instead of inheriting it. Let me show you what I mean.

Say we have a penguin, which is a type of bird, which happens to be able to fly and swim.
And then we have a hawk, also of type bird, which can run, and fly, but not swim. How should we model that?

Implementing this is classical inheritance based OO would be tough because we are only able to extend from one object (bird), and it would be tricky to inherit the ability to fly and swim.

But in Swift this is no problem. Because we can define the requirements in protocols, and then offer the abilities through extensions.

```swift
class Bird {}

protocol Runnable {
    var groundSpeed: Double { get }
    func run() -> String
}
extension Runnable {
    func run() -> String {
        return "Running at \(groundSpeed) mph"
    }
}

protocol Swimmable {
    var waterSpeed: Double { get }
    func swim() -> String
}
extension Swimmable {
    func swim() -> String {
        return "Swimming at \(waterSpeed) mph"
    }
}

protocol Flyable {
    var airSpeed: Double { get }
    func fly() -> String
}
extension Flyable {
    func fly() -> String {
        return "Flying at \(airSpeed) mph"
    }
}

class Penguin : Bird, Runnable, Swimmable {
    var groundSpeed = 2.0
    var waterSpeed = 10.0
}

class Hawk : Bird, Runnable, Flyable {
    var groundSpeed = 2.0
    var airSpeed = 25.0
}
```

This is a very cool mechanic. It allows us to create new requirements via protocols, and then add that new functionality to classes for free, without having to touch or modify the original object in any way.

Here is another example, of how we could add context menu bars to any ViewController.

```swift
import UIKit

protocol ContextMenuDemo {}

extension ContextMenuDemo {
    func makeDefaultDemoMenu() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // Show system share sheet
        }

        // Create an action for renaming
        let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
            // Perform renaming
        }

        // Here we specify the "destructive" attribute to show that it’s destructive in nature
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            // Perform delete
        }

        // Create and return a UIMenu with all of the actions as children
        return UIMenu(title: "", children: [share, rename, delete])
    }
}

class ViewController: UIViewController, ContextMenuDemo {}

extension ViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            return self.makeDefaultDemoMenu() // < HERE
        }
    }

}
```

By defining a protocol, and adding implementation details via an extension, we can add this to any struct, enum, or class simply by having it implement the protocol. No work required on their part.

This is often referred to a protocol oriented programming. The act of adding new functionality to objects via protocols. And it is the preferred way to extend or add abilities to objects in Swift.

### A few things to note;

- Classical inheritance is only available for classes.
- Protocols and extensions work with any Swift type.

```swift
extension Double: Flyable {
    var airSpeed: Double {
        return 42
    }
}
```

### Links that help

* [Protocol Oriented Programming Example](https://medium.com/ios-os-x-development/protocol-oriented-programming-in-swift-daba92bc9c98)
* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Protocol and Value Oriented Programming in UIKit Apps - WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/419/?time=340)
* [Unit testing with protocols](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)


