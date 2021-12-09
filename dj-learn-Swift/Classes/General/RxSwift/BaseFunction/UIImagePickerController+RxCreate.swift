//
//  UIImagePickerController+Rx.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/8.
//  Copyright © 2021 S.J. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImagePickerController {
//    func createPickerFrom(controller: UIViewController) {
//        print("按钮点击")
//        let photosPicker = UIImagePickerController()
//        // 图库类型
//        photosPicker.sourceType = .savedPhotosAlbum
//        // 代理对象（注意添加协议 UIImagePickerControllerDelegate、UINavigationControllerDelegate，及实现代理方法）
//        photosPicker.delegate = self
//        // 设置图片可编辑
//        photosPicker.allowsEditing = true
//        // 改navigationBar背景色
//        photosPicker.navigationBar.barTintColor = UIColor.green
//        // 改navigationBar标题色
//        photosPicker.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
//        // 改navigationBar的button字体色
//        photosPicker.navigationBar.tintColor = UIColor.red
//        photosPicker.sourceType = .photoLibrary
//        self.present(photosPicker, animated: true, completion: nil)
//        
//    }
    
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        let image: UIImage = info[.originalImage] as! UIImage
//    }
}
