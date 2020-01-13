# Let vs Var

Swift combines a lot of good ideas other languages have come up with over the years. One of them, that you may have heard of, is [functional programming](https://en.wikipedia.org/wiki/Functional_programming).

The idea behind functional programming is to minimize the amount of state and mutable data in your programs. That means using as many constants as possible, and minimize the number of variables (or `var`s) that can change.

Swift facilitates this with the `let` and `var` keywords. `var`s can be changed. `let`s cannot.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

Use `let`s wherever you can when programming in Swift. And use `var`s only in those cases where your variable needs to mutate or change. For example when you have an Array that needs to grow.

```swift
var shoppingList = ["catfish", "water", "tulips"]
shoppingList.append("blue paint")
```

