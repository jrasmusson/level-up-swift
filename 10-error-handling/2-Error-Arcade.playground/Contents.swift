/*
  ___                     _                  _
 | __|_ _ _ _ ___ _ _    /_\  _ _ __ __ _ __| |___
 | _|| '_| '_/ _ \ '_|  / _ \| '_/ _/ _` / _` / -_)
 |___|_| |_| \___/_|   /_/ \_\_| \__\__,_\__,_\___|

 */

import Foundation

/*
🕹 Bad Bill - Error.

 Create an error called `BillError` and give it a single case called `negativeAmount`.

 */

enum BillError: Error {
    case negativeAmount
}

/*
🕹 Bad Bill - throws.

 Write a method called payBill that takes an Double amount, and throws an `negativeAmount` error if the bill is a negative amount.
 If the bill is not negative simply print out the amount.
 Then call the method x3 ways - try, try?, try!.

 */

func payBill(_ amount: Double) throws {
    if amount < 0 {
        throw BillError.negativeAmount
    }

    print("Bill payed: $\(amount)")
}

// x3 ways we can call

do {
    try payBill(-1)
} catch {
    print("Error paying bill")
    // Show error message
}

// try? - Optional
try? payBill(1)
try? payBill(-1)

// try! - Forced
try! payBill(1)
// try! payBill(-1) // 💥



/*
🕹 Bad Bill - programmer error

 Take the payBill you just created, and re-write it to genereate a programmer error (assert() or preCondition())
 instead of throwing an error.

 Discussion: What are the differences between these two techniques? Which do you prefer? Why?

 */

func payBill2(_ amount: Double) {
    assert(amount > 0, "Amount can't be negative") // Debug
//    precondition(amount > 0, "Amount can't be negative") // Release 💥
    print("Bill payed: $\(amount)")
}

payBill2(1)
//payBill2(-1)

/*
 Discussion:

 - Advantages of throwing
  - Can signal to client why call failed (more precise error handling).
  - Useful for client input.
  - Use if expected and may need to react

 - Advantages of asserting
  - Good for unexpected programming errors when situation really should not have happened
  - Bug on your part
  - Good to use when developing (can stop and fix bug immediately)
  - Can then decide whether
   - Stop only in degug builds (assertion)
   - Stop in release builds/production (precondition/fatal)
 */
