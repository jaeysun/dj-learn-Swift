//
//  DJNavigationController.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

class DJNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        // 设置导航栏的颜色
        // iOS 15 设置导航栏颜色的方法改变了
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            // 设置背景图片
            let bgImage = UIImage.create(with: UIColor.init(hex: 0xC83C23, alpha: 1))
            navigationBarAppearance.backgroundImage = bgImage
            // 设置标题颜色
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.navigationBar.scrollEdgeAppearance = navigationBarAppearance;
            self.navigationBar.standardAppearance = navigationBarAppearance;
        } else {
            // 设置背景图片
            let bgImage = UIImage.create(with: UIColor.init(hex: 0xC83C23, alpha: 1))
            self.navigationBar.setBackgroundImage(bgImage, for: .default)
            self.navigationBar.shadowImage = UIImage.create(with: UIColor.white)
            // 设置标题颜色
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
