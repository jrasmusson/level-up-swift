/*
  ___     _        _         ___        _
 | _ \___| |_ __ _(_)_ _    / __|  _ __| |___ ___
 |   / -_)  _/ _` | | ' \  | (_| || / _| / -_|_-<
 |_|_\___|\__\__,_|_|_||_|  \___\_, \__|_\___/__/
                                |__/
 */

import UIKit

//
// What is a retain cycle?
//

// Retain cycle is one two objects refer to each other strongly.

class Book {
    var pages = [Page]()

    func add(_ page : Page) {
        pages.append(page)
    }
}

class Page {
    var book : Book

    init(book : Book) {
        self.book = book
    }
}

let book = Book()
let page = Page(book: book)
book.add(page)

//
// How to solve?
//

// 1. Use Structs.

// Structs are passed by value (copied).
// Means when a variable is passed, it's contents are copied leaving the original intact.
// Because there is not pointer to original, there is no retain cycle.

// Classes on the other hand are passed by reference (pointers).
// Means when you pass a classes you are passing a pointer to the original.
// Having two classes holding strong references to each other is what creates the retain cycle.

// This is why Swift is so big on functional style programming.
// Using struct eliminates a whole host of problems.

// 2. Break with weak Optional.

class Book2 {
    var pages = [Page2]()

    func add(_ page : Page2) {
        pages.append(page)
    }
}

class Page2 {
    weak var book : Book?

    init(book : Book) {
        self.book = book
    }
}

let book2 = Book2()
let page2 = Page2(book: book)
book2.add(page2)

//
// Common use cases
//

// Protocol & Delegates

// Protocol / Delegates are one place where you want make sure retain cycles are avoided. One wrinkle here is that if you are working with UIKit, you need to make delegate only conform for `class` or `AnyObject`.

protocol ListViewControllerDelegate : AnyObject {
    func configure(with list : [Any])
}

class ListViewController : UIViewController {

    weak var delegate : ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// Closures

// Closures by default have strong references to the objects that use them. And if you use `self` within a closure, you have a retain cycle between the closure and the object containing it.

class Example2 {

    var counter = 0

    var closure : (() -> ()) = { }

    init() {
        closure = {
            self.counter += 1
            print(self.counter) // retain cycle
        }
    }

    func foo() {
        closure()
    }

}

// The fix for this is to use `[weak self]` when defining the closure.

class Example3 {

    var counter = 1

    var closure : (() -> ()) = { }

    init() {
        closure = { [weak self] in
            self?.counter += 1
            print(self?.counter ?? "") // fixed!
        }
    }

    func foo() {
        closure()
    }

}

// And `[unowned self]` if you are absolutely sure the instance of `self` will never by Optional in the scope of the closure.

class Example4 {

    var counter = 1

    var closure : (() -> ()) = { }

    init() {
        closure = { [unowned self] in
            self.counter += 1
            print(self.counter)
        }
    }

    func foo() {
        closure()
    }

}

// `[unowned self]` is a bit like using try!. It saves you from having to unwrap self when using. But if self is ever null, your program is going to blow up. For that reason `weak` is much safer and is generally preferred.
