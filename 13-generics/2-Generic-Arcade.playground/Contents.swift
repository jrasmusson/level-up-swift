/*
   ___                  _        _                  _
  / __|___ _ _  ___ _ _(_)__    /_\  _ _ __ __ _ __| |___
 | (_ / -_) ' \/ -_) '_| / _|  / _ \| '_/ _/ _` / _` / -_)
  \___\___|_||_\___|_| |_\__| /_/ \_\_| \__\__,_\__,_\___|

 */

import Foundation

/*
🕹 There can only be one.

 Write a single function called `printAnyArray` that prints out values of both Ints and Strings

 */

let intArray = [1,2,3,4,5]
let stringArray = ["abhi", "iOS"]

func printIntArray(_ array:[Int]) {
    array.map { print($0) } // loop through the array and print all values
}
func printStringArray(_ array:[String]) {
    array.map { print($0) } // loop through the array and print all values
}

func printAnyArray<T>(_ array:[T]) {
    array.map { print($0) } // loop through the array and print all values
}

printAnyArray(intArray)
printAnyArray(stringArray)


/*
🕹 Middle child.

 Write a function that returns the Optional middle value for any element in an array.

 Hint: Sort the array first. Then return the middle element.

 */

func middleValue<T: Comparable>(_ array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    let sorted = array.sorted()
    return sorted[(array.count - 1) / 2]
}

let unsortedArrayInts = [2, 1, 3]
let unsortedArrayStrings = ["b", "c", "a"]

print(middleValue(unsortedArrayInts)!) // 2
print(middleValue(unsortedArrayStrings)!) // b

/*
🕹 Stack anything.

Convert the following IntStack into a struct called `Stack` that takes any generic `Element` type and supports push and pop.
 
 */

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

var intOnlyStack = IntStack()
intOnlyStack.push(1)
intOnlyStack.push(2)
intOnlyStack.push(3)

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var stackOfInts = Stack<Int>()
stackOfInts.push(1)
stackOfInts.push(2)
stackOfInts.push(3)
