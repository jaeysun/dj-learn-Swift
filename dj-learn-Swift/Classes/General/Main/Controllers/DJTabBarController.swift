//
//  DJTabBarController.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

class DJTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor.white
            appearance.backgroundEffect = nil;
            // 设置未被选中的颜色
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            // 设置被选中时的颜色
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.init(hex: 0xC83C23, alpha: 1)]
            self.tabBar.standardAppearance = appearance;
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = appearance
            }
        }
        // UI
        let uiHomeVC = DJUIHomeController.init()
        let uiNavC = DJNavigationController.init(rootViewController: uiHomeVC)
        self.addChild(controller: uiNavC, title: "UI", img: "ic_tabbar_ui_nor", selImg: "ic_tabbar_ui_sel")
        // 组件
        let moduleHomeVC = DJModuleHomeController.init()
        let moduleNavC = DJNavigationController.init(rootViewController: moduleHomeVC)
        self.addChild(controller: moduleNavC, title: "Module", img: "ic_tabbar_module_nor", selImg: "ic_tabbar_module_sel")
        // 其它
        let otherHomeVC = DJOthersHomeController.init()
        let otherNavC = DJNavigationController.init(rootViewController: otherHomeVC)
        self.addChild(controller: otherNavC, title: "Other", img: "ic_tabbar_other_nor", selImg: "ic_tabbar_other_sel")
    }
    
    func addChild(controller:DJNavigationController, title:String, img:String, selImg:String) {
        let selImage = UIImage.init(named: selImg)?.scale(to: CGSize(width: 26.0, height: 26.0))?.withRenderingMode(.alwaysOriginal)
        let norImage = UIImage.init(named: img)?.scale(to: CGSize(width: 26.0, height: 26.0))?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.image = norImage
        controller.tabBarItem.selectedImage = selImage
        controller.tabBarItem.title = title
        if #available(iOS 13, *) {
        } else {
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0xC83C23, alpha: 1)], for: .selected)
            controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        }
        self.addChild(controller)
    }
}


