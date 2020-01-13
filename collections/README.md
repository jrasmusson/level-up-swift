# Collections

## Array

```swift
// Empty array
var someInts = [Int]()

// Array literals
var shoppingList = ["Eggs", "Milk"] // mutable
let doneList = ["Groceries", "Movie"] // immutable

// Accessing
shoppingList.count
shoppingList.isEmpty
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
let firstItem = shoppingList[0]
shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)
let newFirstItem = shoppingList.first

// Iterating
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

// higher order functions

// Map - apply same operation to each element in collection
var numbers2 = [1, 2, 3]
var strings2 = numbers2.map { "\($0)" } // closure

// Filter - selects the elements of an array which satisfy a certain condition.
var numbers3 = [1, 2, 3, 4, 5, 6, 7, 8]
var evenNumbers = numbers3.filter { $0 % 2 == 0 } // [2, 4, 6, 8]
var oddNumbers  = numbers3.filter { $0 % 2 == 1 } // [1, 3, 5, 7]

// Reduce - combines all the values from an array into a single value.
var numbers4 = [1, 2, 3, 4, 5]
var sum = numbers4.reduce(0) { $0 + $1 } // 15
```

## Dictionary

```swift
// Empty dictionary
var namesOfIntegers = [Int: String]()

// Add a key value pair
namesOfIntegers[16] = "sixteen"

// Clear
namesOfIntegers = [:]

// Create with name value pair literals
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// Operations
airports.isEmpty
airports["LHR"] = "London" // add
airports["LHR"] = "London Heathrow" // update
let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") // update with old value

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
```

There is also a Set collection but I don't use it so much.

## Mutability

Collections are mutable if assigned to a `var`. Immutable if assigned to a `let`.

	NOTE 
	It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.


### Links that help

- [Swift Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)

