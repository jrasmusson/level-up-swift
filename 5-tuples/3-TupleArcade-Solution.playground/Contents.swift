/*
  _____          _         _                  _
 |_   _|  _ _ __| |___    /_\  _ _ __ __ _ __| |___
   | || || | '_ \ / -_)  / _ \| '_/ _/ _` / _` / -_)
   |_| \_,_| .__/_\___| /_/ \_\_| \__\__,_\__,_\___|
           |_|
 */

/*
🕹 Status code
 
 Write a method called getStatusCode() that returns a hard coded tuple of type (Int, String) containing values 400 and "Not found". Unpack the tuple, and print out the returned values.

 > func getStatusCode() -> tuple {
    // create and retrn tuple here
 }
 
*/

func getStatusCode() -> (code: Int, description: String) {
    return (400, "Not found")
}

let status = getStatusCode()
status.0
status.1
status.code
status.description


/*
🕹 Class to tuple

 Convert the following class into a light weight tuple.
 
 class Flight {
     var airport:String
     var airplane:Int
 }

 Use the class variable names as tuple named parameters, and print out the flight details in a print statement.
 
*/

let flight = (airport: "Calgary", airplane: "222")

print("Flight \(flight.airplane) from \(flight.airport) is ready for take off!")

/*
🕹 Bonus - tuples can be used to parse array loops
 */

let drivers = ["Magnussen", "Raikkonen", "Hamilton", "Verstappen"]

for (index, name) in drivers.enumerated()
{
    print("\(name) has position \(index)")
}

drivers.enumerated().map {
    print($0) // tuple
}

drivers.enumerated().map {
    print("\($0.0) has position \($0.1)")
}
