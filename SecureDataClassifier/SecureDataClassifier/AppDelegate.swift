//
//  AppDelegate.swift
//  SecureDataClassifier
//
//  Created by Sergei A.I. on 09.09.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = ViewController()
        let navigationController = UINavigationController(rootViewController: firstVC)
        window?.backgroundColor = .white
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
