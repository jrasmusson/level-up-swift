import Foundation
import UIKit

/*
  ___         _               _    ___      _         _          _
 | _ \_ _ ___| |_ ___  __ ___| |  / _ \ _ _(_)___ _ _| |_ ___ __| |
 |  _/ '_/ _ \  _/ _ \/ _/ _ \ | | (_) | '_| / -_) ' \  _/ -_) _` |
 |_| |_| \___/\__\___/\__\___/_|  \___/|_| |_\___|_||_\__\___\__,_|

        ___                                    _           _
       | _ \_ _ ___  __ _ _ _ __ _ _ __  _ __ (_)_ _  __ _| |
       |  _/ '_/ _ \/ _` | '_/ _` | '  \| '  \| | ' \/ _` |_|
       |_| |_| \___/\__, |_| \__,_|_|_|_|_|_|_|_|_||_\__, (_)
                    |___/                            |___/

 */

// What is POP?

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
