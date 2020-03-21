/*
  ___                  _              ___ _
 | __|___ __ __ _ _ __(_)_ _  __ _   / __| |___ ____  _ _ _ ___ ___
 | _|(_-</ _/ _` | '_ \ | ' \/ _` | | (__| / _ (_-< || | '_/ -_|_-<
 |___/__/\__\__,_| .__/_|_||_\__, |  \___|_\___/__/\_,_|_| \___/__/
                 |_|         |___/
 */

// @escaping closures are closures that outlive the functions they are executed in.

// Mechanically the difference between escaping and non-escaping is this
func escapingClosure(completionHandler: @escaping () -> Void) {} // @escaping
func nonescapingClosure(closure: () -> Void) {}

class SomeClass {
    var x = 10
    func doSomething() {
        escapingClosure { self.x = 100 } // self
        nonescapingClosure { x = 200 }
    }
}

// @escaping means I want to run this later after the function returns
// That's why I need to refer to `self` in @escaping closures.

// @escaping closures are closures you want to use when
//
// 1. You need to call something asynchronously, or
// 2. You need to access variables beyond the scope of the function.

import Dispatch

class EscapingExamples {

    var closure: (() -> Void)?

    func storageExample(with completion: @escaping (() -> Void)) {
        //This will produce a compile-time error because `closure` is outside the scope of this
        //function - it's a class-instance level variable - and so it could be called by any other method at
        //any time, even after this function has completed. We need to tell `completion` that it may remain in memory, i.e. `escape` the scope of this
        //function.
        closure = completion
    }

    func asyncExample(with completion: @escaping (() -> Void)) {
        //This will produce a compile-time error because the completion closure may be called at any time
        //due to the async nature of the call which precedes/encloses it.  We need to tell `completion` that it should
        //stay in memory, i.e.`escape` the scope of this function.
        DispatchQueue.global().async { // This causes the escape...
            completion()
        }
    }

    func asyncExample2(with completion: @escaping (() -> Void)) {
        //The same as the above method - the compiler sees the `@escaping` nature of the
        //closure required by `runAsyncTask()` and tells us we need to allow our own completion
        //closure to be @escaping too. `runAsyncTask`'s completion block will be retained in memory until
        //it is executed, so our completion closure must explicitly do the same.
        runAsyncTask {
            completion()
        }
    }

    func runAsyncTask(completion: @escaping (() -> Void)) {
        DispatchQueue.global().async {
            completion()
        }
    }

}

/*
  Note: Closures are non-escaping by default.

  This was done for two reasons.

    1. Safety - non-escaping closures are safer because they can’t create retain cycles.
    2. Speed - compiler can optimize non-escaping closures better because they don’t strongly reference objects.

 */
