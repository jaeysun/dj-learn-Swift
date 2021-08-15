//
//  AppDelegate.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/14.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit
import CoreData


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let code1 = Barcode.upc(10, 10, 10, 10)
        let code2 = Barcode.qrCode("这是一个二维码")
    
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = DJTabBarController.init()
        self.window?.makeKeyAndVisible()
        return true
    }

    

}

