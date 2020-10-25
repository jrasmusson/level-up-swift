# Error Handling - do/try/catch

Errors are represented in Swift as enums conforming to the `Error` protocol.

```swift
enum EnrollmentError: Error {
    case inactiveStudent
    case doesNotMeetMinLevel(minLevel: Int)
    case courseFull
}
```

You throw them like this

```swift
func enroll(_ student: Student) throws {
    guard student.active else {
        throw EnrollmentError.inactiveStudent
    }
    guard student.level >= minLevel else {
        throw EnrollmentError.doesNotMeetMinLevel(minLevel: minLevel)
    }
    guard students.count < capacity else {
        throw EnrollmentError.courseFull
    }
    students.append(student)
}
```

and you catch them like this

```swift
class EnrollmentHandler {
    func enroll(_ student: Student, inCourse course: Course) {
        do {
            try course.enroll(student)
            print("Successfully enrolled \(student.name) in \"\(course.name)\"")
        } catch EnrollmentError.inactiveStudent {
            print("\(student.name) is not an active student")
        } catch let EnrollmentError.doesNotMeetMinLevel(minLevel) {
            print("Could not enroll \(student.name). Must at least be at level \(minLevel)")
        } catch EnrollmentError.courseFull {
            print("Could not enroll \(student.name). Course is full")
        } catch {
            print("Unknown error")
        }
    }
}
```

## try, try?, try!

There are three variants of the `try` keyword for dealing with errors.

```swift
try  - Catch the error via do/try/catch
try? - Returns on Optional
try! - Force unwraps 💥
```

For example say we have a function that converts a word into a number, and throws an error if that number is negative.

```swift
enum FormatError: Error {
    case negativeNumber
}

func toWord(_ number: Int) throws -> String {
    guard number > 0 else {
        throw FormatError.negativeNumber // this returns...
    }

    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: NSNumber(value: number)) ?? "unknown"
}
```

Here are the three differnt ways we could use try on that method.

```swift
// 1
do {
    let _ = try toWord(-5)
} catch FormatError.negativeNumber {
    print("Negative number")
}

// 2
let five = try? toWord(5)
let nilValue = try? toWord(-5)

// 3
let alsoFive = try! toWord(5)
// let thisWillBlowUp = try! toWord(-5)
```

`try` uses the `do catch` keywords to explicitly catch the error, and then gives the user a chance to deal with it. They can either throw the error again, handle it in the catch. 

`try?` takes the error returned, and converts it instead into an `Optional` of the return type of the method. This is handy for when you don't want all the boiler plate of the `do catch` and you simply want to know what the value is, and care less about the error thrown.

`try!` essentially disables the error propogation, and assumes that whatever function you call is going to work. If an error is throw, it blows up crashing you program. You should almost never use this, unless you are sure an error will never be throw.



# Programmer errors

Sometimes we make mistakes as programmers, and the we can't handle an error in the program. In these cases it is better to crash than leave your app in an inconsistent state. Here are the five ways to catch programmer errors, and halt your program.

* assert()
* assertionFailure()
* precondition()
* preconditionFailure()
* fatalError()

### assert()

Use asserts for programmer errors.

```swift
func printAge(_ age: Int) {
    assert(age >= 0, "Age can't be a negative value")
    print("Age is: ", age)
}
```

### assertionFailure()

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        assertionFailure("Age can't be a negative value")
        return
    }
    print("Age is: ", age)
}
```

### precondition()

A harder form of assert, precondition will stop your program in debug and release builds.

```swift
func printAge(_ age: Int) {
    precondition(age >= 0, "Age can't be a negative value")
    print("Age is: ", age)
}

printAge(-1) // prints: precondition failed: Age can't be a negative value
```

### preconditionFailure()

Same as above.

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        preconditionFailure("Age can't be a negative value")
    }
    print("Age is: ", age)
}

printAge(-1) // prints: fatal error: Age can't be a negative value
```

If you look a bit closely at the method signature for this function, you’ll see that it has a return type:

```swift
public func preconditionFailure(... file: StaticString = #file, line: UInt = #line) -> Never
```

Return type ‘Never’ indicates that this function will never return. It will stop the execution of the app. That’s why Xcode won’t complain about the guard statement falling through because of the missing return statement.

### fatalError()

fatalError(), like assertionFailure() and preconditionFailure(), takes a string as an argument that will be printed in the console before the app terminates. It works for all optimisation levels in all build configurations. You use it just like the other two:

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        fatalError("Age can't be a negative value")
    }
    print("Age is: ", age)
}

printAge(-1) // prints: fatal error: Age can't be a negative value
```

And just like the preconditionFailure() it has a return type of ‘Never’.

## Common Patterns

One pattern you will see a lot in Swift, particularly when calling asynchronous code, is to return a `Result` type indicating success or failure.

```swift
class DataLoader {
    enum Result {
        case success(Data)
        case failure(Error?)
    }

    func loadData(from url: URL,
                  completionHandler: @escaping (Result) -> Void) {
        let task = urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(error))
                return
            }

            completionHandler(.success(data))
        }

        task.resume()
    }
}
```

In fact this became such a common pattern that in Swift5 they introduced a new [`Result`](https://developer.apple.com/documentation/swift/result) type in Swift to represent this exact dynamic.

```swift
enum NetworkError: Error {
    case dataError
}

class DataLoader {

    func loadData(from url: URL,
                  completionHandler: @escaping (Result<Data,NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }

            completionHandler(.success(data))
        }

        task.resume()
    }
}
```

We will cover `Result` more later in ... after the section on JSON parsing.


### Examples of Non-recoverable

Sometimes errors just can't be recovered from. In those cases `guard` classes and programmer asserts/preconditions/failures work well.

```swift
guard let image = UIImage(named: selectedImageName) else {
    preconditionFailure("Missing \(selectedImageName)")
}

guard let account = session.selectedAccount else { 
    fatalError("attempt to pay bill w/o an account") 
}
```

### Links that help
* [Apple Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)
* [Example1](https://agostini.tech/2017/10/01/assert-precondition-and-fatal-error-in-swift/)
* [Example2](https://khawerkhaliq.com/blog/swift-error-handling/)
* [Sundell on Error Handling](https://www.swiftbysundell.com/posts/picking-the-right-way-of-failing-in-swift)
* [Missing manual](https://blog.krzyzanowskim.com/2015/03/09/swift-asserts-the-missing-manual/)
* [Swift Result Type](https://developer.apple.com/documentation/swift/result)
