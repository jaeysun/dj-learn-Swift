//
//  RXImagePickerController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/8.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RXImagePickerController: DJViewController {
    // 结果图片显示
    var resultImageView: UIImageView = UIImageView()
    // 相册按钮
    var albumButton: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
        
        // 按钮点击事件
        self.albumButton
            .rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map({ info in
                return info[.originalImage] as? UIImage
            })
            .bind(to: self.resultImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    override func configSubviews() {
        super.configSubviews()
        // 背景图片
        self.view.addSubview(self.resultImageView)
        self.resultImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        // 相册按钮
        self.albumButton.setTitle("相册", for: .normal)
        self.albumButton.setTitleColor(UIColor.white, for: .normal)
        self.albumButton.backgroundColor = UIColor.black
        self.view.addSubview(self.albumButton)
        self.albumButton.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
    }
    
}
