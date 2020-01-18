/*
  ___                    _                  _
 | __|_ _ _  _ _ __     /_\  _ _ __ __ _ __| |___
 | _|| ' \ || | '  \   / _ \| '_/ _/ _` / _` / -_)
 |___|_||_\_,_|_|_|_| /_/ \_\_| \__\__,_\__,_\___|

 */

/*
🕹 Grid Warrior
 
 You are a game designer in which your character is exploring a grid like map. You get the original location of the character and the steps he/she will take.
 
 Write the code, that will:
  - increment y + 1 if up
  - decrement y - 1 if down
  - increment x + 1 if right
  - decrement x - 1 if left
 
 Print the final location after all the steps have been taken
 
*/

enum Direction {
    case up
    case down
    case left
    case right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.up, .up, .left, .down, .left]

// your code here

for step in steps {
    switch step {
    case .up:
        location.y += 1
    case .down:
        location.y -= 1
    case .left:
        location.x -= 1
    case .right:
        location.x += 1
    }
}

print("(\(location.x), \(location.y))")

// why not map?

/*
🕹 Rock, Paper, Scissors

 1) Define an enumeration named HandShape with three members: .rock, .paper, .scissors.
 2) Define an enumeration named MatchResult with three members: .win, .draw, .lose.
 3) Write a function called match that takes two hand shapes and returns a match result. It should return the outcome for the first player (the one with the first hand shape).
 */

enum HandShape {
    case rock
    case paper
    case scissors
}

enum MatchResult {
    case win
    case draw
    case lose
}

func match(_ first: HandShape, _ second: HandShape) -> MatchResult {
    if first == second {
        return .draw
    }
    
    if first == .rock && second == .scissors {
        return .win
    }
    
    if first == .paper && second == .rock {
        return .win
    }
    
    if first == .scissors && second == .paper {
        return .win
    }
    
    return .lose
}

match(.rock, .scissors)
match(.rock, .paper)
match(.rock, .rock)
