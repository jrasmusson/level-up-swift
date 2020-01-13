//
//  Factory.swift
//  ContainerView
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-09-27.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = .blue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 40 / 2

    return button
}

func makeLabel(withTitle title: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = title
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 32)
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true

    return label
}

