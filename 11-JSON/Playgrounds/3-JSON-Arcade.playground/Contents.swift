/*
     _ ___  ___  _  _     _                  _
  _ | / __|/ _ \| \| |   /_\  _ _ __ __ _ __| |___
 | || \__ \ (_) | .` |  / _ \| '_/ _/ _` / _` / -_)
  \__/|___/\___/|_|\_| /_/ \_\_| \__\__,_\__,_\___|

 */

import Foundation

/*
🕹 Find the base.
 
 Create a Swift struct called `Coordinate` capable of decoding the incoming JSON message.

 */

let json1 = """
{
    "latitude": 44.4,
    "longitude": 55.5,
}
"""

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

let data1 = json1.data(using: .utf8)!
let result1 = try! JSONDecoder().decode(Coordinate.self, from: data1)
print(result1)

/*
🕹 Associate it with a Planet.
 
 Create a Swift struct called `Planet` to include the following coordinate.

 */

let json2 = """
 {
     "name": "Tatooine",
     "foundingYear": 1977,
     "location": {
         "latitude": 44.4,
         "longitude": 55.5,
     },
 }
"""

struct Planet: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
}

let data2 = json2.data(using: .utf8)!
let result2 = try! JSONDecoder().decode(Planet.self, from: data2)
print(result2)

/*
🕹 Use the force.
 
 Alter the `Planet` struct we just created so it can handle
 
 case name = "planet_name"
 case foundingYear = "founding_year"
 
 */

let json3 = """
 {
     "planet_name": "Tatooine",
     "founding_year": 1977,
     "location": {
         "latitude": 44.4,
         "longitude": 55.5,
     },
 }
"""

struct OtherPlanet: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case name = "planet_name"
        case foundingYear = "founding_year"
        case location
    }
}

let data3 = json3.data(using: .utf8)!
let result3 = try! JSONDecoder().decode(OtherPlanet.self, from: data3)
print(result3)
