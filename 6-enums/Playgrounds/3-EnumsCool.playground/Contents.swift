/*
  ___                      ___          _
 | __|_ _ _  _ _ __  ___  / __|___  ___| |
 | _|| ' \ || | '  \(_-< | (__/ _ \/ _ \ |
 |___|_||_\_,_|_|_|_/__/  \___\___/\___/_|

 */

import UIKit

// Errors

class StringFormatter {
    enum Error: Swift.Error {
        case emptyString
    }

    func format(_ string: String) throws -> String {
        guard !string.isEmpty else {
            throw Error.emptyString
        }

        return string.replacingOccurrences(of: "\n", with: " ")
    }
}

let formatter = StringFormatter()
try! formatter.format("Hello\n Peter!")

// Simple State Machine

enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next() // ovenLight is now equal to .low
ovenLight.next() // ovenLight is now equal to .high
ovenLight.next() // ovenLight is now equal to .off again

// Guard clauses

enum ChatType {
    case authenticated
    case unauthenticated
}

let chatType = ChatType.authenticated
   
func isAuthenticated(chatType: ChatType) -> Bool {
   
    guard chatType == .authenticated else {
        return false
    }
    
    return true
}

// Minize hard coded strings

enum SegueIdentifier: String {
    case Login
    case Main
    case Options
}

let segue = SegueIdentifier.Login

switch segue {
case .Login:
    print("Login")
case .Main:
    print("Main")
case .Options:
    print("Options")
}

// Nice to read code

class NetworkReachabilityManager {
    
    enum NetworkReachabilityStatus: Equatable {
        case unknown
        case notReachable
        case reachable(ConnectionType)
        
        enum ConnectionType {
            case ethernetOrWiFi
            case wwan
        }
    }
    
    var isReachable: Bool { return isReachableOnWWAN || isReachableOnEthernetOrWiFi }
    var isReachableOnWWAN: Bool { return status == .reachable(.wwan) }
    var isReachableOnEthernetOrWiFi: Bool { return status == .reachable(.ethernetOrWiFi) }
    
    var status: NetworkReachabilityStatus {
        return .notReachable
    }
}
