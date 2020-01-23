//
//  Buzzable.swift
//  BuzzableTraditional
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-21.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit


// Traditional

//class BuzzableButton: UIButton {
//    func buzz() {
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.05
//        animation.repeatCount = 5
//        animation.autoreverses = true
//        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
//        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
//        layer.add(animation, forKey: "position")
//    }
//}
//
//class BuzzableTextField: UITextField {
//    func buzz() {
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.05
//        animation.repeatCount = 5
//        animation.autoreverses = true
//        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
//        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
//        layer.add(animation, forKey: "position")
//    }
//}


// Protocol Oriented

protocol Buzzable { // 1. Define protocol.
    func buzz()
}

extension Buzzable where Self: UIView { // 2. Offer default implementation.
  func buzz() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 5
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
    layer.add(animation, forKey: "position")
  }
}

class BuzzableTextField: UITextField, Buzzable {} // 3. Apply where you like.
class BuzzableButton: UIButton, Buzzable, Fadeable {}
