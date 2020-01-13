# How different ?

Enums in Swift are first class citizens. That means they can do a lot more than emums in other languages. For example, in Swift enums can have:

- Computed properties
- Methods
- Initializers
- Extensions
- Generics
- Associated values

## Computed properities

While you can’t store a property directly on a Swift enum like this

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int // 💥
}
```

You can provide computed properties like this

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int {
    switch self {
      case .iPhone: 
        return 2007
      case .iPad: 
        return 2010
    }
  }
}

let device = Device.iPhone
print(device.year)
```

Here you can see we have x2 types of devices, iPad and iPhone, but the year is a computed property based on the state of the enum itself.

## Methods

Enums in Swift also support methods.

```swift
enum Character {
    enum Weapon {
        case bow
        case sword
        case dagger
    }
    
    case thief(weapon: Weapon)
    case warrior(weapon: Weapon)
    
    func getDescription() -> String {
        switch self {
        case let .thief(weapon):
            return "Thief chosen \(weapon)"
        case let .warrior(weapon):
            return "Warrior chosen \(weapon)"
        }
    }
}

let character1 = Character.warrior(weapon: .sword)
print(character1.getDescription())
// prints "Warrior chosen sword"
```

Here is an enum called `Character`, that describes an embedded enum (`Weapon`) but also defines two characters types, `thief` and `warrior`.

## Initializers

Another thing enums can do is initialize themselves.

```swift
enum IntCategory {
    case small
    case medium
    case big
    case weird

    init(number: Int) {
        switch number {
        case 0..<1000 :
            self = .small
        case 1000..<100000:
            self = .medium
        case 100000..<1000000:
            self = .big
        default:
            self = .weird
        }
    }
}

let intCategory = IntCategory(number: 34645)
print(intCategory)
```

This enum doesn't know what its initial value should be. So the initializer takes a value and sets its enum state on itself.

## Extensions

With Swift enum extensions, you can separate your data from methods like this.

```swift
enum Entities {
    case soldier(x: Int, y: Int)
    case tank(x: Int, y: Int)
    case player(x: Int, y: Int)
}

extension Entities {
    mutating func attack() {}
    mutating func move(distance: Float) {}
}

 And you can even add extend and add new functionality to an enum like this.

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .soldier(x, y): return "Soldier position is (\(x), \(y))"
        case let .tank(x, y): return "Tank position is (\(x), \(y))"
        case let .player(x, y): return "Player position is (\(x), \(y))"
        }
    }
}
```

## Generics

And if you are really into Generics, you can even define an enum based on a Generic types too.

```swift
enum Information<T1, T2> {
    case name(T1)
    case website(T1)
    case age(T2)
}

let info = Information.name("Bob") // Error
```

Here the compiler is able to recognize T1 as ‘Bob’, but T2 is not defined yet. Therefore, we must define both T1 and T2 explicitly as shown below.

```swift
let info = Information<String, Int>.age(20)
print(info) //prints age(20)
```


## When should I use enums?

Considering using enums any time you have predefined state. 

```swift
enum Beverage {
    case coffee, tea, juice
}

enum ChatType {
    case authenticated
    case unauthenticated
}

enum Device {
    case iPhone
    case iPad
}
```

Predefined state is when you know all the states a collection of data can be in, and you are looking for a convenient means of grouping them together.

