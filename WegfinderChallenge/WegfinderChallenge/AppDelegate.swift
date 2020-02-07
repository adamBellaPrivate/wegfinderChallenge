//
//  AppDelegate.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupNavigationBarAppearance()
        setupRootViewController()

        return true
    }

}

private extension AppDelegate {

    final func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CitySelectorSceneBuilder().buildScene().presentable.embedInNavigationController()
        window?.makeKeyAndVisible()
    }

    final func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = AppStyle.Color.textPrimary
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: AppStyle.Color.textPrimary as Any]
    }

}
