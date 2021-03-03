# Passing Data by Value versus Reference

Types in Swift fall into one of two categories: first _value Types_, where each instance keeps a unique copy of its data (`struct`, `enum`, or `tuple`). And _reference types_, where instances share a single copy of the data, and the type is usually defined as a `class`. 

In this section we are going to look at 

 - What the difference between value and reference types are
 - Why the distinction is important
 - How this manifests around best practices in the Swift language

## Value types are stored on the Stack

Values types like structs and enums get stored on the Stack. When assign a struct to another variable, you get a copy of the original, both get stored on the stack. If you change one, you don't affect the other. This is much safer and have fewer side effects than passing by reference.

<img src="https://github.com/jrasmusson/level-up-swift/blob/master/8-structs-vs-classes/images/stack.png" alt="drawing" width="600"/>

## Reference types are stored on the Heap

When you pass by reference you are passing a pointer to an object in memory, and when you change that instance in memory, you change it for everyone pointing to it.

<img src="https://github.com/jrasmusson/level-up-swift/blob/master/8-structs-vs-classes/images/heap.png" alt="drawing" width="600"/>

## Stack vs Heap

So why does any of this matter? Performance and safety. Accessing memory on the stack (where values are stored) is much faster than pulling things off the heap (where references are stored). There are also fewer side effects when working with copied data (on the stack) instead of passing around pointers to shared data (from the heap).

<img src="https://github.com/jrasmusson/level-up-swift/blob/master/8-structs-vs-classes/images/stack-vs-heap.png" alt="drawing" width="600"/>

This is why Swift is so big on constants, Structs, Enums, and not so big on Classes. When we code with constructs that can be stored on the Heap, creating and destroying objects isn’t only safer, it’s faster and cheaper.

It also leads to different style of programming - one more functional. Because all data is now copied by value, you work on data, get the result, and then throw it away. You are less worried about side effects. You don’t care what other functions or objects do with your data (because you have your own copy), and you leverage higher order functions like map, filter and reduce to get the results you want, and use less statements (if, else, switch) when programming.

Just to be clear, if else and switch statements are still core parts of the Swift language. And we use them all the time when programming. Just not in the same ways or as often as we did in more traditional OO programming. Classes are still used in Swift. And UIKit uses them extensively to store user interface state and bridge calls to Objective-C.

But if you are wondering why Swift favors certain functional programming paradigms, and you are wondering why more traditional Object-Oriented constructs like classes aren’t used as much, now you know.

It’s for safety, speed, and fewer side-effects.


### Links that help

- [WWDC Video](https://developer.apple.com/videos/play/wwdc2016/416/)
- [StackOverflow](https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap)
- [Apple Value and Reference Types](https://developer.apple.com/swift/blog/?id=10)



