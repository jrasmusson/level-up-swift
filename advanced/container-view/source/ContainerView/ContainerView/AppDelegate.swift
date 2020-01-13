//
//  AppDelegate.swift
//  ContainerView
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-09-27.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()

        return true
    }

}
