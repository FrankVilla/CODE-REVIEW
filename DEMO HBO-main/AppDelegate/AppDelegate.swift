//
//  AppDelegate.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 25/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkMonitor.shared.startMonitoring()
        return true
    }
}

