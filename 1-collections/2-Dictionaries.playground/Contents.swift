/*
  ___  _    _   _                   _
 |   \(_)__| |_(_)___ _ _  __ _ _ _(_)___ ___
 | |) | / _|  _| / _ \ ' \/ _` | '_| / -_|_-<
 |___/|_\__|\__|_\___/_||_\__,_|_| |_\___/__/

 */

// Empty dictionary
var namesOfIntegers = [Int: String]()

// Add a key value pair
namesOfIntegers[16] = "sixteen"

// Clear
namesOfIntegers = [:]

// Create with name value pair literals
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// Operations
airports.isEmpty
airports["LHR"] = "London" // add
airports["LHR"] = "London Heathrow" // update
let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") // update with old value

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

