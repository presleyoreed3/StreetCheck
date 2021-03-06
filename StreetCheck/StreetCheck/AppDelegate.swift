//
//  AppDelegate.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc: UIViewController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (UserDefaults.standard.value(forKey: "name") as? String) == nil {
            vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        } else {
            vc = storyboard.instantiateInitialViewController()!
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true 
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let navigationController = window?.rootViewController as? UINavigationController
//        if let activeController = navigationController!.visibleViewController {
//            vc = activeController
//        }
//
//
//        self.window?.rootViewController = vc
//        self.window?.makeKeyAndVisible()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if (UserDefaults.standard.value(forKey: "password") as? String) == nil {
            vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        }
        else {
            vc = storyboard.instantiateViewController(withIdentifier: "CheckPasswordViewController")
        }

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if (UserDefaults.standard.value(forKey: "password") as? String) == nil {
            vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        }
        else {
            vc = storyboard.instantiateViewController(withIdentifier: "CheckPasswordViewController")
        }

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

