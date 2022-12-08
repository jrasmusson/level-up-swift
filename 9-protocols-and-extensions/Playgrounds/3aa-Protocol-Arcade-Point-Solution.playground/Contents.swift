/*

 ___         _               _     _                  _
| _ \_ _ ___| |_ ___  __ ___| |   /_\  _ _ __ __ _ __| |___
|  _/ '_/ _ \  _/ _ \/ _/ _ \ |  / _ \| '_/ _/ _` / _` / -_)
|_| |_| \___/\__\___/\__\___/_| /_/ \_\_| \__\__,_\__,_\___|

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

enum Direction {
    case left
    case right
    case up
    case down
}

protocol Moveable {
    mutating func move(_ direction: Direction)
    func coordinates() -> String
}

extension Player: Moveable {
    mutating func move(_ direction: Direction) {
        let currentX = position.x
        let currentY = position.y

        switch direction {
        case .left:
            position = Point(currentX - 1, currentY)
        case .right:
            position = Point(currentX + 1, currentY)
        case .up:
            position = Point(currentX, currentY + 1)
        case .down:
            position = Point(currentX, currentY - 1)

        }
    }

    func coordinates() -> String {
        return "(\(position.x), \(position.y)"
    }
}

var player1 = Player()
player1.coordinates()

player1.move(.left)
player1.coordinates()

player1.move(.right)
player1.coordinates()

player1.move(.up)
player1.move(.up)
player1.coordinates()

player1.move(.down)
player1.coordinates()
