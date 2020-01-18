/*
   ___                  _
  / __|___ _ _  ___ _ _(_)__ ___
 | (_ / -_) ' \/ -_) '_| / _(_-<
  \___\___|_||_\___|_| |_\__/__/

 */

import Foundation

//
// What is a generic?
//

// A generic <T> is a placeholder for any type.

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

// This is where generics come in. You can write one method, that takes any generic type T, and so long as it conforms to the Protocol numberic, you can add it.

func addition<T: Numeric>(a: T, b: T) -> T
{
    return a + b
}
let someInt = addition(a: 42, b: 99)
let someFloat = addition(a: 1.1, b: 2.2)

// Two parts to a generic - the type, and the constraint.

// The way to read a function like this is:
//  This function takes any type T, where T conforms to the protocol Numeric, and then returns an instance of type T.

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

//
// Protocols And Associated Types
//

// Protocols can have generics too. They are called `associated types`. For example say we want a storage protocol to work with more than just books.

struct Book {
    let title: String
    let author: String
}

//
//protocol Storage
//{
//    func store(item: Book)
//    func retrieve(index: Int) -> Book
//}
//
//class Bookcase: Storage
//{
//    var books = [Book]()
//
//    func store(item: Book)
//    {
//        books.append(item)
//    }
//
//    func retrieve(index: Int)
//    {
//        return books[index]
//    }
//}

// By making the `Item` book an associated type, storage can now work for any storage item - not just books.

protocol Storage
{
    associatedtype Item
    func store(item: Item)
    func retrieve(index: Int) -> Item
}

// Now you can store anything.

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

// Used extensively in Collections

var arrayOfStrings = Array<String>()
arrayOfStrings.append("abc")

var arrayOfInts = Array<Int>()
arrayOfInts.append(1)
