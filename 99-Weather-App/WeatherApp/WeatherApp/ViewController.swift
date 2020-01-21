//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jonathan Rasmusson Work Pro on 2020-01-17.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Stored property with closure
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your favorite city"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title1)

        return label
    }()

    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textAlignment = .center
        textField.backgroundColor = .systemFill
        
        return textField
    }()

    let weatherButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fetch", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.addTarget(self, action: #selector(weatherButtonPressed), for: .primaryActionTriggered)

        return button
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not set"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)

        return label
    }()

    
    var weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(cityLabel)
        view.addSubview(cityTextField)
        view.addSubview(weatherButton)
        view.addSubview(weatherLabel)
        
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        cityTextField.topAnchor.constraint(equalToSystemSpacingBelow: cityLabel.bottomAnchor, multiplier: 3).isActive = true
        cityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: cityTextField.trailingAnchor, multiplier: 3).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        weatherButton.topAnchor.constraint(equalToSystemSpacingBelow: cityTextField.bottomAnchor, multiplier: 3).isActive = true
        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        weatherLabel.topAnchor.constraint(equalToSystemSpacingBelow: weatherButton.bottomAnchor, multiplier: 3).isActive = true
        weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupDelegates() {
        cityTextField.delegate = self
        weatherService.delegate = self
    }

    // MARK: - Actions
    
    @objc func weatherButtonPressed() {
        guard let city = cityLabel.text else { return }
        weatherService.fetchWeather(for: city)
    }
    
    // MARK: - Textfield
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // gives up keyboard
    }
}


// MARK: - TextField delegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = textField.text else { return } // 3. Optional / Guard
        
        if city != "London" {
            showCityAlert()
        }
    }
    
    func showCityAlert() {
        let alert = UIAlertController(title: "London Calling",
                                      message: "Sorry - only London is currently supported.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

}

// MARK: - WeatherService delegate

extension ViewController: WeatherServiceProtocol {
    func didFetchWeather(_ weather: Weather) {
        weatherLabel.text = "Today is \(weather.forecast) with a high of \(weather.temperature)C"
    }
}
