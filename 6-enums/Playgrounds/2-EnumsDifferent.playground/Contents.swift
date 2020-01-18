/*
  ___                     ___  _  __  __                 _
 | __|_ _ _  _ _ __  ___ |   \(_)/ _|/ _|___ _ _ ___ _ _| |_
 | _|| ' \ || | '  \(_-< | |) | |  _|  _/ -_) '_/ -_) ' \  _|
 |___|_||_\_,_|_|_|_/__/ |___/|_|_| |_| \___|_| \___|_||_\__|

 */

// Computed properties

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
device.year

// Methods

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
character1.getDescription()

// Initializers

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
intCategory

// Extensions

enum Entities {
    case soldier(x: Int, y: Int)
    case tank(x: Int, y: Int)
    case player(x: Int, y: Int)
}

extension Entities {
    func attack() {}
    func move(distance: Float) {}
}

// And you can even add extend and add new functionality to an enum like this.

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .soldier(x, y): return "Soldier position is (\(x), \(y))"
        case let .tank(x, y): return "Tank position is (\(x), \(y))"
        case let .player(x, y): return "Player position is (\(x), \(y))"
        }
    }
}

// Generics

enum Information<T1, T2> {
    case name(T1)
    case website(T1)
    case age(T2)
}

let info = Information<String, Int>.age(20)
info

// Use when you have number grouping of defined state

enum Beverage {
    case coffee, tea, juice
}

enum ChatType {
    case authenticated
    case unauthenticated
}

enum MobileDevice {
    case iPhone
    case iPad
}
