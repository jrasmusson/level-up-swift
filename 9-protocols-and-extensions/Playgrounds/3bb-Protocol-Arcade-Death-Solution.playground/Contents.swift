/*
   ___         _               _   ___      _               _
  | _ \_ _ ___| |_ ___  __ ___| | |   \ ___| |___ __ _ __ _| |_ ___
  |  _/ '_/ _ \  _/ _ \/ _/ _ \ | | |) / -_) / -_) _` / _` |  _/ -_)
  |_| |_| \___/\__\___/\__\___/_| |___/\___|_\___\__, \__,_|\__\___|
                                                 |___/
                        _                  _
                       /_\  _ _ __ __ _ __| |___
                      / _ \| '_/ _/ _` / _` / -_)
                     /_/ \_\_| \__\__,_\__,_\___|
 */

/*
 protocol WeatherServiceDelegate: AnyObject {
     func didFetchWeather(weather: String)
 }

 struct WeatherService {
     weak var delegate: WeatherServiceDelegate?
     
     func fetchWeather() {
         // asynchronous...
         delegate?.didFetchWeather(weather: "22")
     }
 }

 override func viewDidLoad() {
     super.viewDidLoad()
     weatherService.delegate = self // key!
     setupViews()
 }

 extension ViewController: WeatherServiceDelegate {
     func didFetchWeather(weather: String) {
         label.text = weather
     }
 }
 */

/*
🕹 Death Star
 
 Using the Protocol Delegate pattern, create a service that informs General Tarkin in the Command Center when the Death Star's primary canon is ready to fire.
 
 In no particular order you will need to:
  - Create the protocol.
  - Create the service.
  - Create the Command Center.
  - Register the Command Center delegate with the service.
  - Make the Command Center conform to the protocol.
  - Fire the canon! (via a print statement).

 */

import Foundation

protocol DeathStarCanonDelegate {
    func canonReady()
}

struct DeathStarCanonService {
    var delegate: DeathStarCanonDelegate?
    
    func chargePrimaryCanon() {
        delegate?.canonReady()
    }
}

struct CommandCenter {
    
    var service = DeathStarCanonService()
    
    init() {
        service.delegate = self
    }
    
    func fireWhenReady() {
        service.chargePrimaryCanon()
    }
    
    private func fire() {
        print("Boom!")
    }
}

extension CommandCenter: DeathStarCanonDelegate {
    func canonReady() {
        fire()
    }
}

let commandCenter = CommandCenter()
commandCenter.fireWhenReady()

/*
 Discussion:
 - weak var delegate only necessary for class
 
 */
