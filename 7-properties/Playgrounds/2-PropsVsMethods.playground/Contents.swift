/*
  ___                       _   _
 | _ \_ _ ___ _ __  ___ _ _| |_(_)___ ___ __ _____
 |  _/ '_/ _ \ '_ \/ -_) '_|  _| / -_|_-< \ V (_-<
 |_| |_| \___/ .__/\___|_|  \__|_\___/__/  \_//__/
             |_|
         __  __     _   _            _
        |  \/  |___| |_| |_  ___  __| |___
        | |\/| / -_)  _| ' \/ _ \/ _` (_-<
        |_|  |_\___|\__|_||_\___/\__,_/__/

 */

// Which is better

class CircleProperty {
    var radius: Double = 0

    var area: Double { // Property?
        get {
            return radius * radius * Double.pi
        }
    }
}

class CircleMethod {
    var radius: Double = 0

    func area() -> Double { // or argumentless method?
            return radius * radius * Double.pi
    }
}

/*
 It's a little bit style. More about semantics. 🌈

 A property in Swift very much implies some form of access to the current state of a value or object — without changing it. So anything that modifies state, for example by returning a new value, is most likely better represented by a method.

*/

// let finishedEpisode = episode.finished() // Looks like we're performing an action to finish the episode
// let finishedEpisode = episode.finished   // Looks like we're accessing some form of "finished" data

// 🤖 So favor properties when accessing data. And reach for the method when changing it.

// https://www.swiftbysundell.com/articles/computed-properties-in-swift/
