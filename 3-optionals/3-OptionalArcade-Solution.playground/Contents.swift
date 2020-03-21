/*
 _  _ _      _      ___
| || (_)__ _| |_   / __| __ ___ _ _ ___ ___
| __ | / _` | ' \  \__ \/ _/ _ \ '_/ -_|_-<
|_||_|_\__, |_||_| |___/\__\___/_| \___/__/
       |___/
*/

/*
🕹 Unwrap with if-let

Unwrap the following Optional using the if let statement
*/

let firstname: String? = "Sam"

if let x = firstname {
    print(x)
}

/*
🕹 Unwrap with guard

Unwrap the following Optional using the guard statement
*/

enum MyError: Error {
    case invalidUsername
}

let lastname: String? = "Flynn"

guard let y = lastname else {
    throw MyError.invalidUsername // nil
}

print(y)

// from function can early return 🚀

func someFunction(possibleName: String?) {
    
    guard let name = possibleName else {
        return
    }
    
    // name
    print(name)
}

