# Passing Data by Value versus Reference

Types in Swift fall into one of two categories: first _value Types_, where each instance keeps a unique copy of its data (`struct`, `enum`, or tuple). And _reference types_, where instances share a single copy of the data, and the type is usually defined as a `class`. 

In this section we are going to look at 

 - What the difference between value and reference types are
 - Why the distinction is important
 - How this manifests around best practices in the Swift language

## Passing by value

Passed by value (the default in Swift) means you get a copy of whatever data you are working with.

```swift
// Pass by value
struct S { var data: Int = -1 }
var a = S()
var b = a                          // a is copied to b
a.data = 42                        // Changes a, not b
print("\(a.data), \(b.data)")      // prints "42, -1"
```

## Pass by reference 

When you pass by reference you are passing a pointer to an object in memory, and when you change that instance in memory, you change it for everyone pointing to it.

```swift
// Pass by reference
class C { var data: Int = -1 }
var x = C()
var y = x                          // x is copied to y
x.data = 42                        // changes the instance referred to by x (and y)
print("\(x.data), \(y.data)")      // prints "42, 42"
```

## Stack vs Heap

So why does any of this matter? I matters a lot because accessing memory on the stack (where values are stored) is much faster than pulling things off the heap (where references are stored).

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/mechanics/functional/images/stack-vs-heap.png" alt="drawing" width="600"/>

This is why Swift is so big on constants, Structs, Enums, and not so big on Classes. When we code with constructs that can be stored on the Heap, creating and destroying objects isn’t only safer, it’s faster and cheaper.

It also leads to different style of programming - one more functional. Because all data is now copied by value, you work on data, get the result, and then throw it away. You are less worried about side effects. You don’t care what other functions or objects do with your data (because you have your own copy), and you leverage higher order functions like map, filter and reduce to get the results you want, and use less statements (if, else, switch) when programming.

Just to be clear, if else and swtich statements are still core parts of the Swift language. And we use them all the time when programming. Just not in the same ways or as often as we did in more traditional OO programming. Classes are still used in Swift. And UIKit uses them extensively to store user interface state and bridge calls to Objective-C.

But if you are wondering why Swift favors certain functional programming paradigms, and you are wondering why more traditional Object-Oriented constructs like classes aren’t used as much, now you know.

It’s for safety, speed, and fewer side-effects.


### Links that help

- [StackOverflow](https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap)
- [Apple Value and Reference Types](https://developer.apple.com/swift/blog/?id=10)



