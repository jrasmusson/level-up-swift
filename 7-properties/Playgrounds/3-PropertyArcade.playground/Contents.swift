/*
  ___                       _            _                  _
 | _ \_ _ ___ _ __  ___ _ _| |_ _  _    /_\  _ _ __ __ _ __| |___
 |  _/ '_/ _ \ '_ \/ -_) '_|  _| || |  / _ \| '_/ _/ _` / _` / -_)
 |_| |_| \___/ .__/\___|_|  \__|\_, | /_/ \_\_| \__\__,_\__,_\___|
             |_|                |__/

 */

 import Foundation

/*
🕹 Dog years

   Create a struct called person, with a storied property of type Int called age, and then add a computed property called ageInDogYears of type Int that returns the age of the person in dog years (age * 7).
 */


struct Person {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var joe = Person(age: 25)
joe.ageInDogYears


/*
🕹 isEquilateral

    Given the following Triangle stucture, write a computed property that determines whether the sides of the triangle are equilateral (all three sides are equal).

    var isEquilateral: Bool {
        return ?
    }

 */

struct Triangle {
    let edgeA: Int
    let edgeB: Int
    let edgeC: Int

    var isEquilateral: Bool {
        return edgeA == edgeB && edgeB == edgeC
    }
}

let triangle = Triangle(edgeA: 5, edgeB: 5, edgeC: 5)
triangle.isEquilateral

/*
🕹 Title in the Post

 Add a property observer stored property title that trims white space and new lines when the title stored property is set.

 > struct Post
 > var title: String
 > title.trimmingCharacters(in: .whitespacesAndNewlines)

 */

struct Post {
    var title: String {
        // 😓 Not called during initialization
        didSet {
            self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

var post = Post(title: "    spaces     ")   // must be var
post.title                                  // didSet not called
post.title = "   no spaces    "             // didSet called
post.title

/*
 Discussion:
  - The property is automatically set for us in the observer
  - We can modify the property value in the observer
  - Setting a property in its own didSet callback doesn’t cause infinite recursion.
*/

/*
🕹 Observe the radius

    Define a class of type Circle. Give it a stored property `radius` of type `Double`.
    And use the `didSet` property observer to ensure no negative values get assigned to radius.
    If negative number, assign radius value of 0.

 */


class Circle {

    // Discussion: There is a lot going on here...
    // - stored property (didSet/didGet) w/ property observer
    // - default value
    // - radius is automatically set to `newValue`
    // - newValue / oldValue

    var radius: Double = 0 {
        didSet {
            if radius < 0 {
                radius = oldValue
            }
        }
    }
}

let circle = Circle()

circle.radius = 12
circle.radius = -10 // 0

/*
🕹 Compute the area

 Building on the previous example, calculate the circles area as a computed property.

 Hint: area = radius * radius * Double.pi

 */

class ACircle {

    var radius: Double = 0 {
        didSet {
            if radius < 0 {
                radius = oldValue
            }
        }
    }

    // Discussion:
    // - Computed property (get/set)

    var area: Double {
        get {
            return radius * radius * Double.pi
        }
    }

}

let aCircle = ACircle()
aCircle.radius = 5
aCircle.area


/*
🕹 Set the radius via the square root.

    Building on previous question, add a setter to the computed property area. When the area is set, have it set the stored property radius.
 */
class BCircle {

    var radius: Double = 0 {
        didSet {
            if radius < 0 {
                radius = oldValue
            }
        }
    }

    var area: Double {
        get {
            return radius * radius * Double.pi
        }
        set(newArea) {
            radius = sqrt(newArea / Double.pi)
        }
    }

}

let bCircle = BCircle()

bCircle.area = 25
bCircle.radius
