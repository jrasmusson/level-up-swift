# Properties

Swift properies come intwo types: stored and computed.

```swift
struct SomeStruct {
    // Stored Property
    var stored: String = "stored"

    // Computed Property
    var computed: String {
        return "computed"
    }
}
```

## Stored Properties

Stored properies are just like any plain old property. You set the value to the variable name and the property gets created.

```swift
struct SomeStruct {
    var aString = "A string"
    var aNumber = 1
    var aBool = false
}
```

### Property Observers

You can observe changes to properties via *property observers*. These observe and respond to changes in a property’s value and are called everytime a property’s value is set. We don't use these a tonne, but they can be handy if you want to do some pre/post processing or extra validation before or after a property is set.

- willSet
- didSet

```swift
struct SomeStruct {

    // Property Observers
    var storedObserver: String {
        willSet {
            print("willSet was called")
            print("stored is now equal to \(self.storedObserver)")
            print("stored will be set to \(newValue)")
        }

        didSet {
            print("didSet was called")
            print("stored is now equal to \(self.storedObserver)")
            print("stored was previously set to \(oldValue)")
        }
    }
}
```

`newValue` and `oldValue` are default names assigned to new and old values as they are passed in. But you are free to choose others names for these if you like.

```swift
struct Person {
    var clothes: String {
        willSet(newClothes) {
            print("I'm changing from \(clothes) to \(newClothes)")
        }

        didSet(oldClothes) {
            print("I just changed from \(oldClothes) to \(clothes)")
        }
    }
}
```

### Stored properies as blocks

One pattern you will see a lot when building apps is stored properies being created from blocks.

```swift
class HomeController: UIViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "home"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

}
```

It may initially look a little weird, but by defining your stored propery, and setting it equal to a `{}` block followed by closing parenthesis `()` so that it executes, you can created complex objects inlined right when you define them.

#### Lazy 

One wrinkle, is if the block you are defining needs acces to `self`, you need to mark the property as `lazy`.

```swift
class LoginController: UIViewController {

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = self.pages.count + 1 // lazy var for self

        return pageControl
    }()
    
}
```

This delays creating the stored property until the property is actually called and the object instance (`self`) is fully created. `lazy` is also handy for only creating really expensive objects until you actually need them (as opposed to when the object is initially created).


## Computed Properties

Computed properties are properties that don't actually store nothing. They computed and return values instead.

```swift
struct SomeStruct {

    var computed: String {
        return "computed"
    }

    let baseRate: Decimal = 0.5
    var interestRate: Decimal {
        return baseRate + 0.1
    }
}
```    
 
### Getter and Setter

Computed properties can be used for getting and setting internal values within a class or struct. If a setter doesn’t define a name for new value, a default value of _newValue_ is used.

```swift
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
```

If entire body of getter is a single expression, the getter implicitly returns that expression (no return key word required)

```swift
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
    }
}
```

### Read-Only Computed Properties

Computed property with a getter but no setter is a _read-only_ computed property.
Can be accessed through dot syntax - cannot be set.
You can simplifiy the declaration of a read-only computed property by removing the _get_ keyword and its braces.

> Note: All computed properties must be vars because their value is not fixed. 
```swift
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume
```

### Stored vs Computed Properties (get/Set vs didGet/didSet)

Confusion can naturally occur when it comes to choosing between `get/set` and `didGet/didSet` for stored and computed properties. Here are some rules of thumb.

Use a stored property (`get/set`) when you need the value of the property for processing in other parts of the struct or class.

```swift
class PercentDataLimitReachedView: UIView {
    private var _percentUsed = 0

    // computed property
    var percentUsed: Int {
        get {
            return _percentUsed
        }
        set {
            _percentUsed = newValue
        }
    }

    func log() {
        print("\(_percentUsed)")
    }
}
```

Use a computed property (`didGet/didSet`) if you are just reacting to a change in property.

```swift
class PercentDataLimitReachedView: UIView {
    let label = UILabel()

    // stored property
    var percentUsed: Int = 0 {
        didSet {
            label.text = String(percentUsed)
            isHidden = !(percentUsed >= 75)
        }
    }
}
```


### Working with UIKit and Classes

A subtle for confusing point is why you can define UIKit variables as `let` and then modify them later. To mutate this label, shouldn't it have to be a `var`?

```swift
let highLimitLabel = UILabel()
highLimitLabel.text = "\(limit) GB"
```

The reason why this is OK is because the reference to the label is a let (meaning it can never change) but the label itself is not a value type construct (struct or enum). It is a class. Which is mutable.

So even they you define the reference to a class as a let, you can still mutate it because it is a reference type - and not a value type.

## Property Wrappers

Adds a layer of separation between code that manages how a property is stored and the code that defines a property.
It’s like a little bit of processsing before a property is stored. Can use for extra checks and data validation.

```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
```

> Note: By making number _private_ above we can ensure people go through our property wrapper and never access _number_ directly.

You apply to a property by writing the wrapper’s name before the property as an attribute.

```swift
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
```

Could also declare like this.

```swift
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
```

This is a popular pattern for any time your want to protect your internal data (make it private) and force users to go through public property API. 

## Type Properties

These are like statics in other languages.
Properties belonging to the type itself - not their instances.
Universal to all instances of a particular type.
Can be variables or constants.
Must always have a default value because type itself has no initalizer that it can assign value to.

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

### Links that help

- [Apple Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)
- [NSHipster Property Wrapper](https://nshipster.com/propertywrapper/)
