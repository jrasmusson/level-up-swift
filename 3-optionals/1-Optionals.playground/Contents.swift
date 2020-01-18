let number1: Int = Int(42)
let number2: Int = 42
let number3 = 42

let possibleNumber: Int? = 42
let number = possibleNumber! // Yay ✅

//var possibleNumber: Int?
//let number = possibleNumber! // Boom 💥

//if let number = possibleNumber {
//    print("We have a number \(number)!")
//} else {
//    print("Sorry. No soup for you.")
//}
//
//func printNumber(possibleNumber: Int?) {
//
//    guard let number = possibleNumber else {
//        print("No number here.")
//        return
//    }
//
//    print("We have a number \(number)!")
//}


let shortForm: Int? = Int("42")
let myOptional: Int? = 4


//enum Optional<T> {
//    case some<T>
//    case none
//}
