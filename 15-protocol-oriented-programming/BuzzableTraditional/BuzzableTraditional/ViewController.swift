//
//  ViewController.swift
//  BuzzableTraditional
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-21.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textField: BuzzableTextField = {
        let textField = BuzzableTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .title1)
        textField.textAlignment = .center
        textField.backgroundColor = .systemFill
        textField.placeholder = "User name"

        return textField
    }()

    var button: BuzzableButton = {
        let button = BuzzableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.backgroundColor = .systemBlue
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
    }

    func setupDelegates() {
        textField.delegate = self
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(button)

        textField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 3).isActive = true
        textField.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true

        button.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
    }

    // MARK: - Textfield actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // gives up keyboard on touch
    }

    // MARK: - Button actions
    @objc func buttonPressed(sender: UIButton!) {
        textField.buzz()
        button.buzz()
        button.fade()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
