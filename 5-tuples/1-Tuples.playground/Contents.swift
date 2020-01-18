/*
  _____          _
 |_   _|  _ _ __| |___ ___
   | || || | '_ \ / -_|_-<
   |_| \_,_| .__/_\___/__/
           |_|
 */

// A tuple is a group of zero or more values represented as one value.

let error = (404, "Not Found")

// You can access via index
let code = error.0 // 404
let description = error.1 // Not Found

// Or named parameters
var person = (firstName: "John", lastName: "Smith")

var firstName = person.firstName // John
var lastName = person.lastName // Smith

// Define like any other constant or variable. Can change if a var.
var point = (0, 0)

point.0 = 10
point.1 = 15

point // (10, 15)

// Tuples are value types. When you initialize one type with another you get a copy.
var origin = (x: 0, y: 0)

var point1 = origin
point1.x = 3
point1.y = 5

origin // (0, 0)
point1 // (3, 5)

// Tuples have types.
let atuple = ("tuple", 1, true) // (String, Int, Bool)

// An empty tuple () represents type Void

// Can be decomposed
let aPerson = (firstN: "John", lastN: "Smith")

let (firstN, lastN) = aPerson // decomposing same named elements
let (first, last) = aPerson   // decomposing different named elements

var (onlyFirstName, _) = aPerson // _ means we don't care
var (_, onlyLastName) = aPerson

firstN
lastN
onlyFirstName
onlyLastName

// Can initialize more than one variable in a single line.
// Instead of
//
// var a = 1
// var b = 2
// var c = 3
//
// can

var (a, b, c) = (1, 2, 3)
a
b
c

// Then can change values in one line also

(a, b, c) = (4, 5, 6)
a
b
c

// Tuples are also handy for those cases where you want to return mutiple values
func split(name: String) -> (firstName: String, lastName: String) {
    let split = name.split(separator: " ")
    return (String(split[0]), String(split[1]))
}

let parts = split(name: "John Smith")
parts.0
parts.1
parts.firstName
parts.lastName


