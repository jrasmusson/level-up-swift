/*
  ___                       _   _
 | _ \_ _ ___ _ __  ___ _ _| |_(_)___ ___
 |  _/ '_/ _ \ '_ \/ -_) '_|  _| / -_|_-<
 |_| |_| \___/ .__/\___|_|  \__|_\___/__/
             |_|

 */

// There are two types of properties in Swift

struct S {
    // Stored Property
    var stored: String = "stored"

    // Computed Property
    var computed: String {
        return "computed"
    }
}

// Stored

struct StoredProperties {
    var stored: String = "stored"

    // Lazy
    lazy var importer = "lazy"

    // Property Observers
    var storedObserver: String {
        willSet {
            print("willSet was called")
            print("stored is now equal to \(self.stored)")
            print("stored will be set to \(newValue)")
        }

        didSet {
            print("didSet was called")
            print("stored is now equal to \(self.stored)")
            print("stored was previously set to \(oldValue)")
        }
    }
}

// Computed

struct ComputedProperties {

    var computed: String {
        return "computed"
    }

    private var _stored = "stored"

    // Short hand - think of as a wrapper
    var shortHand: String {
        get {
            return _stored
        }
        set {
            _stored = newValue
        }
    }
}

//
// Examples
//

// Lazy Stored Properites

class DataImporter { // If expensive
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter() // Make lazy - created when needed
    var data = [String]()
}

//
// Computed Examples (classes, structs, enums)
//

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()

    // Computed - not stored
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

// Shorthand getter - no return

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get { // no return necessary
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// Read-Only - getter no setter

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

// Property Observers- Stored Property

// - allow you to react to setting of properties
// - useful for extra processing - can embed in classes instead of client calling

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

// Type Properties
// - like statics in other languages, assigned to type, all instances get

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
