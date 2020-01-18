/*
  ___                             _   _
 | __|_ _ _  _ _ __  ___ _ _ __ _| |_(_)___ _ _  ___
 | _|| ' \ || | '  \/ -_) '_/ _` |  _| / _ \ ' \(_-<
 |___|_||_\_,_|_|_|_\___|_| \__,_|\__|_\___/_||_/__/

 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// single line
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// assign to variables
var directionToHead = CompassPoint.west

// can infer type
directionToHead = .east

// match with switch statement
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

// can assign default if not all used
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// can associate values
enum Barcode {
    case upc(Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem):
    print("UPC: \(numberSystem)")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

// can associate raw values (Strings, Characters, Ints, Floating Point)
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let spacer = ASCIIControlCharacter.tab.rawValue

// can implicitly assign raw values
enum OtherPlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum OtherCompassPoint: String {
    case north, south, east, west
}

let earthsOrder = OtherPlanet.earth.rawValue

let sunsetDirection = OtherCompassPoint.west.rawValue




