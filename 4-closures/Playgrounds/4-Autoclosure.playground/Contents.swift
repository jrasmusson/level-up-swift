
/*
    _       _           _
   /_\ _  _| |_ ___  __| |___ ____  _ _ _ ___ ___
  / _ \ || |  _/ _ \/ _| / _ (_-< || | '_/ -_|_-<
 /_/ \_\_,_|\__\___/\__|_\___/__/\_,_|_| \___/__/

 */

//  Swift’s @autoclosure attribute enables you to define an argument that automatically gets wrapped in a closure. It’s primarily used to defer execution of a (potentially expensive) expression to when it’s actually needed, rather than doing it directly when the argument is passed.

var isDebug = true

func assert(_ expression: () -> Bool,
            _ message: () -> String) {
    guard isDebug else {
        return
    }

    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
}

func someCondition() -> Bool { return false }

assert({ someCondition() }, { "Hey, it failed!" })  // without

func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {
    guard isDebug else {
        return
    }

    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
}

assert(someCondition(), "Hey it failed!")           // with

// So @autoclosure is syntatic sugar that wraps closures in { ...} for us.
// But you have to be careful how you read this...

// assert({ someCondition() }, { "Hey, it failed!" })

// Because we are passing in a closure, realize that this doesn't get executed immediately.
// The closure only gets run when explicitly called in the function to which is is passed.
// Just beware of this. Can be confusing at first.
