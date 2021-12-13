//
//  RXSimpleValidController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/13.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxSwift

class RXSimpleValidController: DJViewController {
    // 用户名
    var nameTextField: UITextField = UITextField()
    // 密码
    var passworldField: UITextField = UITextField()
    // 登录按钮
    var loginButton: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 用户名：数字或字母组成的4-16位的字符串
        // ^[0-9a-zA-Z]{4,16}$
        let userNameVaild = nameTextField.rx.text.orEmpty.map { username -> Bool in
            /// 正则规则字符串
            let pattern = "^[0-9a-zA-Z]{4,16}"
            /// 正则规则
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            if let matches = regex?.matches(in: username, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: username.count)) {
                return matches.count > 0
            } else {
                return false
            }
        }
        let nameTextBinder:Binder<Bool> = Binder(nameTextField){ (textField, value) in
            textField.textColor = (value ? UIColor.black : UIColor.red)
        }
        userNameVaild.bind(to: nameTextBinder).disposed(by: self.disposeBag)
        
        // 密码：同时包含字母、数字、特殊字符组成的8-16位字符串
        let passwordVaild = passworldField.rx.text.orEmpty.map { password -> Bool in
            /// 正则规则字符串
            /// ^(?=.*[a-zA-Z\d])[!-~]{8,16}
            ///
            let pattern = "^(([a-zA-Z]+)([0-9]+)){8,16}"
            /// 正则规则
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            if let matches = regex?.matches(in: password, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: password.count)) {
                return matches.count > 0
            } else {
                return false
            }
        }
        let passwordBinder:Binder<Bool> = Binder(passworldField){ (textField, value) in
            textField.textColor = (value ? UIColor.black : UIColor.red)
        }
        passwordVaild.bind(to: passwordBinder).disposed(by: self.disposeBag)
        
        // 用户名和密码同时符合要求才可以点击

    }
    
    override func configSubviews() {
        super.configSubviews()
        
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = UIColor.red
        nameTextField.placeholder = "请输入用户名"
        self.view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(50.0)
            make.right.equalTo(self.view).offset(-50.0)
            make.top.equalTo(self.view).offset(180.0)
            make.height.equalTo(40.0)
        }
        
        passworldField.borderStyle = .roundedRect
        passworldField.textColor = UIColor.red
        passworldField.placeholder = "请输入密码"
        passworldField.isSecureTextEntry = true
        self.view.addSubview(passworldField)
        passworldField.snp.makeConstraints { make in
            make.left.right.equalTo(nameTextField)
            make.top.equalTo(nameTextField.snp.bottom).offset(20.0)
            make.height.equalTo(nameTextField)
        }
        
        loginButton.setTitle("登   录", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.backgroundColor = UIColor.gray
        loginButton.layer.cornerRadius = 4.0
        loginButton.layer.masksToBounds = true
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passworldField.snp.bottom).offset(20.0)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(nameTextField)
        }
    }
}

