# Generics

Generics are how computer languages write one function for many types. Instead of having to write many functions for the adding of various types.

```swift
func additionInt(a: Int, b: Int) -> Int
{
    return a + b
}
let resultInt = additionInt(a: 42, b: 99)

func additionFloat(a: Float, b: Float) -> Float
{
    return a + b
}
let resultFloat = additionFloat(a: 1.1, b: 2.2)
```

Generics enable you to write one addition method for multiple types.

```swift
func addition<T: Numeric>(a: T, b: T) -> T
{
    return a + b
}
let someInt = addition(a: 42, b: 99)
let someFloat = addition(a: 1.1, b: 2.2)
```

# How to they work?

There are two parts to a generic - the type, and the constraint.

The **type** represents the generic type given to any object passed into the function. By convention you will often see this named T, U, Item, or Element. But you are free to give it any name you like.

The **constraint** (in this case Numeric) limits the type of objects that can be passed in to only those implementing that protocol. You are free to use any protocol here you like (even your own). There are also optional. But Swift defines and often uses these in its libraries.


 - `Equatable` for values that can be equal, or not equal
 - `Comparable` for values that can be compared, like a > b
 - `Hashable` for values that can be “hashed”, which is a unique integer representation of that value (often used for dictionary keys)
 - `CustomStringConvertible` for values that can be represented as a string, a helpful protocol for quickly turning custom objects into printable strings
 - `Numeric` and `SignedNumeric` for values that are numbers, like 42 and 3.1415
 - `Strideable` for values that can offset and measured, like sequences, steps and ranges
 
## Different ways of applying constraints

There is more than one way of constraining a type on a generic. Depending on which elements you want to apply the constraint, you can either do it directly on the struct, via an extension, or by type directly on the extension itself.

```swift
struct Stack<Element:Equatable> { // Every element in Stack must be equatable

extension Container where Item: Equatable { // Only Items in this extension must be equatable

extension Container where Item == Double { // Only items in this extension must be of type double
```
 
## How to read them

```swift
func addition<T: Numeric>(a: T, b: T) -> T
```

The way to read a function like this is:

- This function takes any type T, where T conforms to the protocol Numeric, and then returns an instance of type T.

This nest method finds the index for any item within an array. To work however, the type needs to be `Equatable`.

```swift
func findIndex<T: Equatable>(of foundItem: T, in items: [T]) -> Int?
{
    for (index, item) in items.enumerated()
    {
        if item == foundItem {
            return index
        }
    }
    return nil
}
```

Not every generic needs a constraint. You can for instance simply use the constraint by itself like in this example of a stack. Note here how we give the generic type a name of `Element`.

```swift
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
```

## Protocols And Associated Types

Protocols can have generics too. They are called `associated types`. For example say we want a storage protocol to work with more than just books.

```swift
struct Book {
    let title: String
    let author: String
}

protocol Storage
{
    func store(item: Book)
    func retrieve(index: Int) -> Book
}

class Bookcase: Storage
{
    var books = [Book]()

    func store(item: Book)
    {
        books.append(item)
    }

    func retrieve(index: Int)
    {
        return books[index]
    }
}
```

By making the `Item` book an associated type, storage can now work for any storage item - not just books.

```swift
protocol Storage
{
    associatedtype Item
    func store(item: Item)
    func retrieve(index: Int) -> Item
}
```

Now you can store anything.

```swift
class Trunk<Item>: Storage
{
    var items:[Item] = [Item]()

    func store(item: Item)
    {
        items.append(item)
    }

    func retrieve(index: Int) -> Item
    {
        return items[index]
    }
}

let bookTrunk = Trunk<Book>()
bookTrunk.store(item: Book(title: "1984", author: "George Orwell"))
bookTrunk.store(item: Book(title: "Brave New World", author: "Aldous Huxley"))
print(bookTrunk.retrieve(index: 1).title)

struct Shoe {
    let size: Int
    let brand: String
}

let shoeTrunk = Trunk<Shoe>()
shoeTrunk.store(item: Shoe(size: 42, brand: "Nike"))
shoeTrunk.store(item: Shoe(size: 99, brand: "Adidas"))
print(shoeTrunk.retrieve(index: 0).brand)
```

### Links that help

- [Apple Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)
- [Learn App Making](https://learnappmaking.com/generics-swift-how-to/)
- [Performance Differences Between Protocols and Generics - Advanced](https://developer.apple.com/videos/play/wwdc2016/416/)
