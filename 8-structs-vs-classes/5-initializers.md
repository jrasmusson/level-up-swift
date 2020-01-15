# Initializers

Initializers in Swift are pretty straight forward so long as you remember one thing - everything, except Optionals, needs a value before your can use it. Let's look at some examples.

This is a Swift initializer and this is what we use to create new object instances from Structs and Classes. Sometimes referred to as a constructor, so long as every stored property has a value, by the time the initializers finishes, everything is good to go.

```swift
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
```

## Default Property Values

Of course if we define a stored property with a default value, the initializer isn't even required. We get a free no arg constructor and we can set the default property value as part of its declaration.

```swift
struct Celcius {
    var temperature = 24.0
}
var c = Celcius()
```

This method is preferred if you know the property is always going to take the same value, as it makes for shorter, clearer initializers and enables you to infer the type of the property from its default value.


## Initialization Parameters

You can provide initialization parameters as part of an intializers definition.

```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
``

## Memberwise Initializers for Structure Types

Structure types automatically get a free initializer if they don't define any custom initializer themselves.

```swift
struct Color {
    let red, green, blue: Double
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
```

## Default initializers

Swift provides a default initializer for any struct or class that provides default values for all of its properties and does not provide at least one initializer for itself.

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```

## Assigning Constant Properties During Initialization

You can assign a value to a constant property at any point during initialization, so long as it is set by the time initialization finishes. Once set, it can no longer by modified.

```swift
class SurveyQuestion {
    var response: String?
    let text: String        // dont need to set value here...
    init(text: String) {
        self.text = text    // ...but it has to be set here
    }
    func ask() {
        print(text)
    }
}
let bearQuestion = SurveyQuestion(text: "Which type of bear is best?")
bearQuestion.ask()
bearQuestion.response = "Black bear is best."
```

## Failable initializers

Swift has the ability to fail initialization (return a nil). Say for example you only want to create an attachment for specific supported mimeTypes. You could do it like this.

```swift
struct Attachment {
   let fileURL: URL
   let uuid: String
   let mimeType: String
   
   init?(fileURL: URL, uuid: String, mimeType: String) {
      guard mimeType.isMimeType else { return nil }
      
      self.fileURL = fileURL
      self.uuid = uuid
      self.mimeType = mimeType
   }
}
```
   
### Links that help

- [Swift Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)
