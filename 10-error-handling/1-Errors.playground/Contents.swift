/*
  ___                   _  _              _ _ _
 | __|_ _ _ _ ___ _ _  | || |__ _ _ _  __| | (_)_ _  __ _
 | _|| '_| '_/ _ \ '_| | __ / _` | ' \/ _` | | | ' \/ _` |
 |___|_| |_| \___/_|   |_||_\__,_|_||_\__,_|_|_|_||_\__, |
                                                    |___/
 */

import Foundation
import UIKit

/*
 There are four ways to handle errors in Swift:
- Propogate the error with a throw
- Handle the error with a do-catch
- Return an optional, or
- Assert that the error will not occcur
- Returning an error via completion handler block
*/


// An error
enum EnrollmentError: Error {
    case inactiveStudent
    case doesNotMeetMinLevel(minLevel: Int)
    case courseFull
}

// You can throw an error like this
struct Student {
    let active = false
    let level = 1
    let name = "Peter"
}

let minLevel = 0
let capacity = 10
var students = [Student]()

struct Course {
    let name = "Math"
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
}

// And then catch it like this
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

// Recoverable Errors
//   These errors result from networks being down, users entering invalid data.
//   These are are things we can recover from and give a good UI experience when handling.
//   Return nil or an error enum case or throw an error.
// Returning error in a result
class DataLoader {
    enum Result {
        case success(Data)
        case failure(Error?)
    }

    func loadData(from url: URL,
                  completionHandler: @escaping (Result) -> Void) {
        let urlSession = URLSession.shared
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

let loader = DataLoader()
loader.loadData(from: URL(string: "http://invalid.com")!) { (result) in

    // Option 1: Switch
    switch result {
    case .success(_):
        print("Good data")
    case .failure(_):
        print("Bad data")
    }

}

// Throwing
class StringThrowingFormatter {
    enum StringError: Error {
        case emptyString
    }

    func format(_ string: String) throws -> String {
        guard !string.isEmpty else {
            throw StringError.emptyString
        }

        return string.replacingOccurrences(of: "\n", with: " ")
    }
}

// Optional is often better
class StringNilFormatter {

    func format(_ string: String) -> String? {
        guard !string.isEmpty else {
            return nil
        }

        return string.replacingOccurrences(of: "\n", with: " ")
    }
}

// Non Recoverable Errors
// assert() - debug builds / won't 💥 program in production
func printAge(_ age: Int) {
    assert(age >= 0, "Age can't be a negative value")

    print("Age is: ", age)
}

// assertionFailure() - debug builds
func printAge2(_ age: Int) {
    guard age >= 0 else {
        assertionFailure("Age can't be a negative value")
        return
    }
    print("Age is: ", age)
}

// precondition() - debug builds / release 💥
func printAge3(_ age: Int) {
    precondition(age >= 0, "Age can't be a negative value")

    print("Age is: ", age)
}

// preconditionFailure() - debug builds / release 💥
func printAge4(_ age: Int) {
    guard age >= 0 else {
        preconditionFailure("Age can't be a negative value")
    }
    print("Age is: ", age)
}

// fatalError() - hard stop all builds 💥
func printAge5(_ age: Int) {
    guard age >= 0 else {
        fatalError("Age can't be a negative value")
    }
    print("Age is: ", age)
}
