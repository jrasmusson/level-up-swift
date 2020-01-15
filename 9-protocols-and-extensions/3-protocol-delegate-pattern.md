# Protocol Delegate Pattern

Protocol delegate pattern is used all over iOS as a means of communcating back from one object to another when something interesting happens. 

It is used extensively in UIKit, for example

- UITableViewController
- UICollectionViewController
- UITextField

And it is the primary go to way of having subviews communicate back to parent views in iOS.

## How it works

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/mechanics/protocols-delegates/images/protocol.png" alt="drawing" width="600"/>

1. You define a protocol in the child.
2. The parent sets themselves up as the delegate.
3. The parent implements, or conforms to the protocol.
4. The child can now send the parent messages, or ask for data.

## An example

Say we have a WeatherService we want to update our UI after it fetches the weather asynchronously. We can define a _WeatherService_, with a _protocol_ called _WeatherServiceDelegate_...

<img src="https://github.com/jrasmusson/level-up-ios/blob/master/mechanics/protocols-delegates/images/example.png" alt="drawing" width="400"/>


```swift
import Foundation

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
```

have the viewController create a _WeatherService_ object, and register itself as the delegate to callback...

```swift
    override func viewDidLoad() {
		...
       weatherService.delegate = self // key!
		...
    }
```

And then have the viewController conform to the protocols delegate, so that when the delegate is called

```swift
struct WeatherService {
    func fetchWeather() {
        delegate?.didFetchWeather(weather: "22")
    }
}
```

The viewController gets updated.

```swift
extension ViewController: WeatherServiceDelegate {
    func didFetchWeather(weather: String) {
        label.text = weather
    }
}
```

### Things to note

1. The delegate is an optional weak var.

```swift
struct WeatherService {
    weak var delegate: WeatherServiceDelegate?
```

To avoid retain cycles, we don't want to maintain bi-directionally strong references between the ViewController and the WeatherService protocol delegate. To prevent that, the delegate is weakly held by the WeatherService, and strongly held by the viewController. 



## Advantages of Working this way

### Enables asynchronous communication back

While there is nothing inherently asynchronous about the protocol delegate pattern itself, it can be used in asynchronous ways to enable callbacks from child objects, to their parents when something interesting happens. 

This prevents viewControllers from blocking the main UI thread, and allows UI updates to occur asynchronously when they happen.

### Decoupling

The service requiring the protocol doesn't need to know anything about the owner object creating it. It simply defines an interface. So long as owner conform to that protocol / interface, the child object can call it without knowing anything about the parent.

This enables multiple parent objects of different types, to all reuse the same child.

### Clear coupling

Unlike `NotificationCenter` which broadcasts updates out, protocol delegate has a very direct one-to-one couple between the parent and the child. This makes communication simple, clear, and easy.

## Source Code

```swift
import Foundation

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
```

```swift
import UIKit

class ViewController: UIViewController {

    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray
        label.text = "?"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get weather", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = .systemBlue
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }()
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.delegate = self // key!
        setupViews()
    }

    func setupViews() {
        view.addSubview(label)
        view.addSubview(button)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: label.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: label.heightAnchor).isActive = true
    }
    
    @objc func buttonPressed() {
        weatherService.fetchWeather()
    }
}

extension ViewController: WeatherServiceDelegate {
    func didFetchWeather(weather: String) {
        label.text = weather
    }
}
```
