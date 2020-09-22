//
//  DJImageExtension.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 通过颜色生成图片
    /// - Parameter color: 生成图片的颜色
    /// - Returns: 生成的图片
    class func create(with color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        if let cxt = context {
            cxt.setFillColor(color.cgColor)
            cxt.fill(rect)
        }
        let resultIMG:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resultIMG
    }
    
    /// 缩放图片到指定尺寸
    /// - Parameter size: 目标尺寸
    /// - Returns: 生成的新图片
    func scale(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

