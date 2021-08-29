//
//  RSBFController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/16.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RSBFController: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 一、Button 点击事件
        let button1 = UIButton(type: .custom)
        button1.backgroundColor =  UIColor.black
        button1.setTitle("UIButton 点击事件", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(30.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        
        button1.rx.tap.subscribe(onNext: {
            print("点了,小鸡炖蘑菇")
        }).disposed(by: disposeBag)
        
        // UITextField 文本响应
        let textField1 = UITextField()
        self.view.addSubview(textField1)
        textField1.layer.borderWidth = 1
        textField1.layer.borderColor = UIColor.black.cgColor
        textField1.placeholder = "UITextField 文本响应"
        textField1.textAlignment = .center
        textField1.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(30.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        
        textField1.rx.text.orEmpty.subscribe { text in
            print(text)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("onCompleted")
        }.disposed(by: disposeBag)

        let label1 = UILabel()
        self.view.addSubview(label1)
        label1.textColor = .white
        label1.backgroundColor = UIColor.black
        label1.textAlignment = .center
        label1.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(30.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        textField1.rx.text.bind(to: label1.rx.text).disposed(by: disposeBag)
        
    }
    
}
