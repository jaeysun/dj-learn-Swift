//
//  AppDelegate.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/14.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = DJTabBarController.init()
        self.window?.makeKeyAndVisible()
        return true
    }
}

