/*
  ___      _ _   _      _ _         _   _
 |_ _|_ _ (_) |_(_)__ _| (_)_____ _| |_(_)___ _ _
  | || ' \| |  _| / _` | | |_ / _` |  _| / _ \ ' \
 |___|_||_|_|\__|_\__,_|_|_/__\__,_|\__|_\___/_||_|

 */

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()

// Default initializers / Property Values

struct Celcius {
    var temperature = 24.0
}
var c = Celcius()

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


// Initialization Parameters

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

// Memberwise Initializers for Structure Types

struct Color {
    let red, green, blue: Double
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)


// Assigning Constant Properties During Initialization

class SurveyQuestion {
    var response: String?
    let text: String        // Can define here...
    init(text: String) {
        self.text = text    // ...but must set here.
    }
    func ask() {
        print(text)
    }
}
let bearQuestion = SurveyQuestion(text: "Which bear is best?")
bearQuestion.ask()
bearQuestion.response = "Black bear is best."


