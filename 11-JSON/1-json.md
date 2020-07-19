# JSON

The key to parsing JSON in Swift is the JSONEncoder and JSONDecoder.

## JSON > Swift

```swift
let json = """
 {
    "type": "US Robotics",
    "model": "Sportster"
 }
"""

struct Modem: Codable {
    let type: String
    let model: String
}

let jsonData = json.data(using: .utf8)!
let result = try! JSONDecoder().decode(Modem.self, from: jsonData)
```

## Swift > JSON

```swift
var modem = Modem(type: "Hayes", model: "5611")

let jsonData2 = try! JSONEncoder().encode(modem)
let json2 = String(data: jsonData2, encoding: .utf8)!
```

## Coding keys

Use these for when the JSON and Swift property names are different.

```swift
struct User:Codable
{
    var firstName:String
    var lastName:String
    var country:String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case country
    }
}

let jsonUser = """
{
    "first_name": "John",
    "last_name": "Doe",
    "country": "United Kingdom"
}
"""

let jsonUserData = jsonUser.data(using: .utf8)!
let userResult = try! JSONDecoder().decode(User.self, from: jsonUserData)
```

## Codable types

URL, Number, Bool, Array, Dictionary, Enum, Date, Null, and all other custom Codable types.

```swift
import Foundation

let json = """
 {
     "name": "The Witcher",
     "seasons": 1,
     "rate": 9.3,
     "favorite": null,
     "genres":["Animation", "Comedy", "Drama"],
     "countries":{"Canada":"CA", "United States":"USA"},
     "platform": {
         "name": "Netflix",
         "ceo": "Reed Hastings"
     },
    "mobile": "ios",
    "url":"https://en.wikipedia.org/wiki/BoJack_Horseman"
 }
"""

struct Show: Decodable {
    let name: String
    let seasons: Int
    let rate: Float
    let favorite: Bool?
    let genres: [String]
    let countries: Dictionary<String, String>
    let platform: Platform
    let mobile: Mobile
    let url: URL
    
    struct Platform: Decodable {
        let name: String
        let ceo: String
    }

    enum Mobile: String, Codable {
        case ios
        case android
    }
}

let data = json.data(using: .utf8)!
let result = try! JSONDecoder().decode(Show.self, from: data)
result.platform.ceo
result.mobile
```

## Dates

### Milliseconds

```swift
// If milliseconds - nothing to do.

let jsonMs = """
{
  "date" : 519751611.12542897
}
"""

struct DateRecord : Codable {
    let date: Date
}

let msData = jsonMs.data(using: .utf8)!
let msResult = try! JSONDecoder().decode(DateRecord.self, from: msData)
msResult.date
```

### iso8601

```swift
// If iso8601 use dateEncodingStrategy.

let jsonIso = """
{
  "date" : "2017-06-21T15:29:32Z"
}
"""

let isoData = jsonIso.data(using: .utf8)!
let isoDecoder = JSONDecoder()
isoDecoder.dateDecodingStrategy = .iso8601
let isoResult = try! isoDecoder.decode(DateRecord.self, from: isoData)
isoResult.date
```

### Custom DateFormatter

```swift
// If non-standard use `DateFormatter`.

let jsonNS = """
{
  "date" : "2020-03-19"
}
"""

// Define custom DateFormatter
extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

let nsData = jsonNS.data(using: .utf8)!
let nsDecoder = JSONDecoder()
nsDecoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
let nsResult = try! nsDecoder.decode(DateRecord.self, from: nsData)
nsResult.date
```

### Links that help

- [Apple Codable](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
- [Learn App Making](https://learnappmaking.com/codable-json-swift-how-to/)
- [Example](https://benscheirman.com/2017/06/swift-json/)
