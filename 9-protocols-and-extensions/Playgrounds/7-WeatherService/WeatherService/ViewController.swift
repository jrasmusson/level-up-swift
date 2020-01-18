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
        button.addTarget(self, action: #selector(buttonPressed), for: .primaryActionTriggered)
        
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
