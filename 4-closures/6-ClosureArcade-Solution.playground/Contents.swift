
/*
   ___ _                       ___      _      _   _
  / __| |___ ____  _ _ _ ___  / __| ___| |_  _| |_(_)___ _ _  ___
 | (__| / _ (_-< || | '_/ -_) \__ \/ _ \ | || |  _| / _ \ ' \(_-<
  \___|_\___/__/\_,_|_| \___| |___/\___/_|\_,_|\__|_\___/_||_/__/
*/

/*
🕹 K times

Write a function named applyKTimes that takes an integer K and a closure and calls the closure K times. The closure will not take any parameters and will not have a return value.

> applyKTimes(K: 3, closure: { print("I heart Swift") })

*/

// Long hand
func applyKTimes(K: Int, closure: () -> Void) {
    for _ in 1...K {
        closure()
    }
}

applyKTimes(K: 3, closure: { print("I heart Swift") })

// Short hand
func applyKTimesShort(_ K: Int, _ closure: () -> ()) {
    for _ in 1...K {
        closure()
    }
}

applyKTimes(K: 3, closure: {
    print("I heart Swift")
})

applyKTimesShort(3) {
    print("I heart Swift")
}


/*

🕹 Div3

Use filter to create an array called multiples that contains all the multiples of 3 from a given array.

let numbers = [1, 2, 3, 4, 6, 8, 9, 3, 12, 11]

> let multiples = numbers.filter { ? }                     // Hint: Modulus Operator

// [3, 6, 9, 3, 12]

*/

let numbers1 = [1, 2, 3, 4, 6, 8, 9, 3, 12, 11]
let multiples = numbers1.filter { $0 % 3 == 0 }
print(multiples)

/*
🕹 Max

Find the largest number from numbers and then print it. Use reduce to solve this exercise.

*/

let numbers2 = [4, 7, 1, 9, 6, 5, 6, 9]

let max = numbers2.reduce(numbers2[0]) {
    if $0 > $1 {
        return $0
    } else {
        return $1
    }
}

print(max) // 9


/*

🕹 Join

Join all the strings from strings into one using reduce. Add spaces in between strings. Print your result.

> var strings = ["We", "Heart", "Swift"]
> "We Heart Swift"

*/

var strings = ["We", "Heart", "Swift"]

let result = strings.reduce("") {
    if $0 == "" {
        return $1
    } else {
        return "\($0) \($1)"
    }
    
} // trailing closure

print(result)

/*

🕹 Chains

Find the sum of the squares of all the odd numbers from numbers and then print it. Use map, filter and reduce to solve this problem.

> var numbers = [1, 2, 3, 4, 5, 6]
> 25 // 1 + 9 + 25 -> 25

*/

var numbers = [1, 2, 3, 4, 5, 6]

let oddNumbers = numbers.filter { $0 % 2 == 1 }
print(oddNumbers)

let squared = oddNumbers.map{ $0 * $0 }
print(squared)

let summed = squared.reduce(0) { $0 + $1 }
print(summed)

// all combined
let sum = numbers.filter {
        $0 % 2 == 1 //select all the odd numbers
    }.map {
        $0 * $0 // square them
    }.reduce(0, +) // get their sum

print(sum)

/*

🕹 For each

Implement a function forEach(array: [Int], _ closure: Int -> ()) that takes an array of integers and a closure and runs the closure for each element of the array.

var array = [1,2,3,4]
forEach(array) {
    print($0 + 1)
}
// This will be printed:
// 2
// 3
// 4

*/

func forEach(array: [Int], closure: (Int) -> ()) {
    array.map { closure($0) }
}

var array = [1,2,3,4]


forEach(array: array, closure: { print($0) }) // inlined

forEach(array: array) { // trailing
    print($0 + 1000)
}


/*
🕹 Bonus: Combine arrays

Implement a function combineArrays that takes 2 arrays and a closure that combines 2 Ints into a single Int. The function combines the two arrays into a single array using the provided closure. Assume that the 2 arrays have equal length.

> var array1 = [1,2,3,4]
> var array2 = [5,5,5,3]

combineArrays(array1,array2) {
    $0 * $1
}

> [5,10,15,12]
 
*/
var array1 = [1,2,3,4]
var array2 = [5,5,5,3]

func combineArrays(_ array1: [Int], _ array2: [Int], closure: (Int, Int) -> Int) -> [Int] {
    var result: [Int] = []
    for i in 0..<array1.count {
        result.append(closure(array1[i],array2[i]))
    }
    return result
}

let withReturn = combineArrays(array1, array2) {
    return $0 * $1
}
print(withReturn)

let noReturn = combineArrays(array1, array2) {
    $0 * $1
}
print(noReturn)
