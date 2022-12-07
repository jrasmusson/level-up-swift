/**

 Protocol Arcade

*/

/*
 🕹️ Moveable Player.
*/

//Given

struct Point {
    let x: Int
    let y: Int
    
    init (_ x: Int, _ y: Int)  {
        self.x = x
        self.y = y
    }
}

struct Player {
    var position = Point(0,0)
}

// 1. Define an enum called `Direction` that allows a player to move left, right, up, and down
