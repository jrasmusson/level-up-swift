# Cool things you can do with Swift enums ⚡

[Swift Enums](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) are most more powerful than the traditional integer based enumerations we worked with in C. In this article I want to show you some of the cool things Swift enums can do, to make your code more readable and your programs easier to understand.

## Errors

Enums are the way to represent errors in Swift.

```swift
class StringFormatter {
    enum Error: Swift.Error {
        case emptyString
    }

    func format(_ string: String) throws -> String {
        guard !string.isEmpty else {
            throw Error.emptyString
        }

        return string.replacingOccurences(of: "\n", with: " ")
    }
}
```

## Simple State Machines

Here is an example of an enum that can mutate its own state, and treat itself like a simple state machine.

```swift
enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next() // ovenLight is now equal to .low
ovenLight.next() // ovenLight is now equal to .high
ovenLight.next() // ovenLight is now equal to .off again
```

Note the mutating method. This is necessary for declaring that this function will change this enums state - because by default enums don’t really change state - they simply represent it. This mutating keyword lets this enum change the state of itself.

## Guard clauses

Here is an example of how enums can be used in guard clauses.

```swift
enum ChatType {
    case authenticated
    case unauthenticated
}

class NewChatViewController: UIViewController {

    let chatType: ChatType

    public init(chatType: ChatType) { ... }

    guard chatType == .authenticated else {
        return
    }
}
```

If the type chat isn’t authenticated then we had better return early from this initializer in the ViewController. Enums make this really readable and clear.

## Minimize hard coded strings

With Swift enums you don’t even need to put up with hard coded strings. Instead you can define an enum of fixed type String, and then switch on it when you are preparing for segues in view controllers.

```swift
enum SegueIdentifier: String {
    case Login
    case Main
    case Options
}

override func prepareForSegue(...) {
    if let identifier = segue.identifier ... {
        switch segueIdentifier {
        case .Login:
            ...
        case .Main:
            ...
        case .Options:
            ...
        }
    }
    
    SequeIdentifer.Main.rawValue // returns the `String representation`
}
```

Note that last line there. Raw value. That represents the raw underlying value of the enum, and if you even want the actual string, or whatever enum is represented as, you just call it.

## Enums as errors

One pattern you see a lot in Swift is enums being used as errors. 

```swift
public enum AFError: Error {

    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    public var underlyingError: Error? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason.underlyingError
        case .multipartEncodingFailed(let reason):
            return reason.underlyingError
        case .responseSerializationFailed(let reason):
            return reason.underlyingError
        default:
            return nil
        }
    }

}

extension AFError {
    /// Returns whether the AFError is an invalid URL error.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}
```

Here is an example of an AlamoFire error (popular CocoaPod) and look at how beautifully it captures and represents all the different ways it’s errors can be.

Aldo not the extension method here at the bottom. Extension are great ways to add nice helper APIs to an already defined enum. In this case whether the URL is invalide due to the URL.

## Fluent Interfaces

And enums can just lead to some really nice code. Checkout this example of NetworkReachability that defines in enums all the way networks can’t be reached, and then through a series or really nice computed properties, all the various ways you can conveniently check.

```swift
class NetworkReachabilityManager {
    
    enum NetworkReachabilityStatus: Equatable {
        case unknown
        case notReachable
        case reachable(ConnectionType)
        
        enum ConnectionType {
            case ethernetOrWiFi
            case wwan
        }
    }
    
    // MARK: - Properties
    var isReachable: Bool { return isReachableOnWWAN || isReachableOnEthernetOrWiFi }
    var isReachableOnWWAN: Bool { return status == .reachable(.wwan) }
    var isReachableOnEthernetOrWiFi: Bool { return status == .reachable(.ethernetOrWiFi) }
    
    var status: NetworkReachabilityStatus {
        return .notReachable
    }
}
```

## Summary

`Enums` are much more than simple switch statements on type. In Swift, we can leverage enums in much more expressive creative way. Let me know if you find any more cool examples as I am still playing with all the different things you can do with these things.

Happy coding! 🤖
