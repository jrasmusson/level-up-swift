//
//  Poppable.swift
//  BuzzableTraditional
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-21.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

protocol Fadeable {
    func fade()
}

extension Fadeable where Self: UIView {
    func fade() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.alpha = 1.0 }) { (animationCompleted) in
                        if animationCompleted == true {
                            UIView.animate(withDuration: 0.3,
                                           delay: 2.0,
                                           options: .curveEaseOut,
                                           animations: { self.alpha = 0.0 },
                                           completion: nil)
                        }
        }
    }
}

