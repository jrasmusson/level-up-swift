/*
  ___ _               _                  ___ _
 / __| |_ _ _ _  _ __| |_ ___ __ _____  / __| |__ _ ______ ___ ___
 \__ \  _| '_| || / _|  _(_-< \ V (_-< | (__| / _` (_-<_-</ -_|_-<
 |___/\__|_|  \_,_\__|\__/__/  \_//__/  \___|_\__,_/__/__/\___/__/

 */

//
// Differences
//

// 1. Structs don't get classical inheritance (use protocols/extensions instead).

struct StructA {}
//struct StructB: StructA {} // 💥

// 2. Structs give you a default initializer.

struct Resolution {
    var width = 0
    var height = 0
}
let vga = Resolution(width: 640, height: 480)

// 3. Structs are value types. Classes are reference types.

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

hd.width
cinema.width

class VideoMode {
    var name = ""
}

let tenEighty = VideoMode()
tenEighty.name = "1080"

let alsoTenEighty = tenEighty
alsoTenEighty.name = "1080i"

tenEighty.name
alsoTenEighty.name

// 4. Classes have identify operators.

if tenEighty === alsoTenEighty { // class only
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

//
// So if Structs are so great, when, if ever, would be want to use a class?
//

// 1. Interop Objective-C (UIKit)
//     - extending UIViewController, UITableViewController etc

// 2. Need identify

// 3. Want classical inheritance.
