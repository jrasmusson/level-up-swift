//
//  ViewController.swift
//  ContainerView
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-09-27.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .white

        let homeButton = makeButton(withText: "Start")

        view.addSubview(homeButton)

        homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        homeButton.addTarget(self, action: #selector(buttonPressed), for: .primaryActionTriggered)
    }

    @objc func buttonPressed() {
        let container = ContainerViewController()
        present(container, animated: true)
    }
}
