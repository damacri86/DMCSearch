//
//  AppDelegate.swift
//  DMCSearch
//
//  Created by damacri86 on 08/23/2017.
//  Copyright (c) 2017 damacri86. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

