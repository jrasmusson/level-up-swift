# Retain cycles


## What is a retain cycle?

A retain cycle is one two objects refer to each other strongly.

```swift
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
```

Because variable types in objects are by default strong references, when Book refers to Page, and Page back to book, a retain cycle is created, and neither object can be released because each has reference to the other.

## How to solve?

### 1. Use structs.

Structs are passed by value (copy on write). Means when a variable is passed, it's contents are copied leaving the original intact. Because there is not pointer to original, there is no retain cycle.

Classes on the other hand are passed by reference (pointers). Means when you pass a classes you are passing a pointer to the original. Having two classes holding strong references to each other is what creates the retain cycle.

This is why Swift is so big on functional style programming. Using struct eliminates a whole host of problems.

### 2. Break with weak Optional.

```swift
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
```

## Common use cases

### Protocol & Delegates

Protocol / Delegates are one place where you want make sure retain cycles are avoided. One wrinkle here is that if you are working with UIKit, you need to make delegate only conform for `class` or `AnyObject`.

```swift
protocol ListViewControllerDelegate : AnyObject {
    func configure(with list : [Any])
}

class ListViewController : UIViewController {

    weak var delegate : ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
```

### Closures

Closures by default have strong references to the objects that use them. And if you use `self` within a closure, you have a retain cycle between the closure and the object containing it.

```swift
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
```

The fix for this is to use `[weak self]` when defining the closure.

```swift
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
```

And `[unowned self]` if you are absolutely sure the instance of `self` will never by Optional in the scope of the closure.

```swift
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
```

`[unowned self]` is a bit like using try!. It saves you from having to unwrap self when using. But if self is ever null, your program is going to blow up. For that reason `weak` is much safer and is generally preferred.

### Links that help

- [Avoiding retain cycles](https://medium.com/mackmobile/avoiding-retain-cycles-in-swift-7b08d50fe3ef)
- [Weak vs Unowned](http://www.thomashanning.com/retain-cycles-weak-unowned-swift/)
- [Weak vs Unowned2](https://krakendev.io/blog/weak-and-unowned-references-in-swift)
- [How to detect retain cycles in app](http://www.thomashanning.com/retain-cycles-weak-unowned-swift/)
