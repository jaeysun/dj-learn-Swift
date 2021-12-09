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
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let bgImage = UIImage.create(with: UIColor.init(hex: 0xC83C23, alpha: 1))
        self.navigationBar.setBackgroundImage(bgImage, for: .default)
        self.navigationBar.shadowImage = UIImage.create(with: UIColor.white)
    }
}
