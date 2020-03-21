/*
   ___           _            _            __   __    _
  / __|__ _ _ __| |_ _  _ _ _(_)_ _  __ _  \ \ / /_ _| |_  _ ___ ___
 | (__/ _` | '_ \  _| || | '_| | ' \/ _` |  \ V / _` | | || / -_|_-<
  \___\__,_| .__/\__|\_,_|_| |_|_||_\__, |   \_/\__,_|_|\_,_\___/__/
           |_|                      |___/
 */

/*
 A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0 // we can define a value here
    func incrementer() -> Int {
        runningTotal += amount // and then capture and use it here (even though out of scope)!
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen() // 10
incrementByTen() // 20
incrementByTen() // 30

// Closures are reference types

/*
 Whenever you assign a function or a closure to a constant, you are actually setting that constant to be a reference to the function or closure. That means if you assign a closure to two different variables, both will refer to the same closure.
 */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 40

incrementByTen() // 50
