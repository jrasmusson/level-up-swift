/*
         ___         _               _
        | _ \_ _ ___| |_ ___  __ ___| |
        |  _/ '_/ _ \  _/ _ \/ _/ _ \ |
        |_| |_| \___/\__\___/\__\___/_|

  ___      _            _ _
 |_ _|_ _ | |_  ___ _ _(_) |_ __ _ _ _  __ ___
  | || ' \| ' \/ -_) '_| |  _/ _` | ' \/ _/ -_)
 |___|_||_|_||_\___|_| |_|\__\__,_|_||_\__\___|

 */

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

// Real world example

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

// Note:
// - Classical inheritance still here. Only available for classes.

struct Aa {}
//struct Bb: Aa {}

class Foo {}
class Bar: Foo {}

// - Protocols & Extensions can add functionality to any type (not just class, struct, enum).

extension Double: Flyable {
    var airSpeed: Double {
        return 42
    }
}

