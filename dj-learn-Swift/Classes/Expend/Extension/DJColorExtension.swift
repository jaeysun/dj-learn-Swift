//
//  DJColorExtension.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

extension UIColor {
    /// 通过16进制Int数，创建颜色
    /// - Parameters:
    ///   - hex: 16进制数
    ///   - alpha: 透明度
    convenience init(hex:Int, alpha:CGFloat) {
        let red = ((CGFloat)((hex & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((hex & 0xFF00) >> 8))/255.0
        let blue = ((CGFloat)(hex & 0xFF))/255.0
        let alpha = alpha
        self.init(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    }
}
