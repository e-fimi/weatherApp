//
//  AppDelegate.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let container = ModuleContainer.assemble()
        let viewController = container.viewController
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
        
    }
    
}

