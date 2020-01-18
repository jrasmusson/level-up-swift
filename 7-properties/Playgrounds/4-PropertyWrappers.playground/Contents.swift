/*
  ___                       _         __      __
 | _ \_ _ ___ _ __  ___ _ _| |_ _  _  \ \    / / _ __ _ _ __ _ __  ___ _ _ ___
 |  _/ '_/ _ \ '_ \/ -_) '_|  _| || |  \ \/\/ / '_/ _` | '_ \ '_ \/ -_) '_(_-<
 |_| |_| \___/ .__/\___|_|  \__|\_, |   \_/\_/|_| \__,_| .__/ .__/\___|_| /__/
             |_|                |__/                   |_|  |_|

 */

// - layer of separation between storage and processing
// - handy for extra checks and validation

@propertyWrapper
struct TwelveOrLess {
    private var number = 0 // private
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
rectangle.height

rectangle.height = 10
rectangle.height

rectangle.height = 24
rectangle.height // 12

// Handy pattern for protecting variables and forcing through property API

struct AnotherSmallRectangle {
    private var _height = TwelveOrLess() // extra processing
    private var _width = TwelveOrLess()  // and validation
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
