//
//  DJLoginController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/9/2.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DJLoginController: DJViewController {
        
    let userNameField = UITextField()
    let userNameTipLabel = UILabel()
    let pwdField = UITextField()
    let pwdTipLael = UILabel()
    let loginButton = UIButton(type: .custom)
    
    var event: Signal<Void>?
    var event1: Driver<Void>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 用户名是否有效
        let userNameVaild = userNameField.rx.text.orEmpty.map { txt in
            txt.count >= 5
        }.share(replay: 1)
        
        // 用户名是否有效 -> 密码输入框是否可用
        userNameVaild.bind(to: pwdField.rx.isEnabled).disposed(by: disposeBag)
        // 用户名是否有效 -> 用户名提示语是否隐藏
        userNameVaild.bind(to: userNameTipLabel.rx.isHidden).disposed(by: disposeBag)
        
        // 密码是否有效
        let pwdVaild = pwdField.rx.text.orEmpty.map { txt in
            txt.count >= 6
        }.share(replay: 1)
        
        //  密码是否有效 -> 密码提示语是否隐藏
        pwdVaild.bind(to: pwdTipLael.rx.isHidden).disposed(by: disposeBag)
        
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
            userNameVaild,
            pwdVaild)
            { $0 && $1 } // 取用户名和密码同时有效
            .share(replay: 1)
        everythingValid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        let state: Driver<String?> = self.userNameField.rx.text.asDriver()
        let observer = userNameTipLabel.rx.text
        state.drive(observer)
        
        let newObserver = pwdTipLael.rx.text
        state.map { $0?.count.description }.drive(newObserver)
        
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        event1 = loginButton.rx.tap.asDriver()
//        event = loginButton.rx.tap.asSignal()
        let observer1: () -> Void = { self.showAlert("弹出提示框1") }
//        event!.emit(onNext: observer1)
        event1!.drive(onNext: observer1)
        
    }
    
    @objc func loginButtonAction() {
        let newObserver1: () -> Void = { self.showAlert("弹出提示框2") }
//        event!.emit(onNext: newObserver1)
        event1!.drive(onNext: newObserver1)

    }
    
    func showAlert(_ msg: String) {
        print(msg)
    }
    
    override func configSubviews() {
        super.configSubviews()
        
        self.view.addSubview(userNameField)
        userNameField.layer.borderWidth = 1
        userNameField.layer.borderColor = UIColor.black.cgColor
        userNameField.placeholder = "请输入用户名"
        userNameField.snp.makeConstraints { make in
            make.centerY.equalTo(self.view).offset(-160.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        
        self.view.addSubview(userNameTipLabel)
        userNameTipLabel.text = "用户名至少为5位组成"
        userNameTipLabel.textColor = UIColor.red
        userNameTipLabel.font = UIFont.systemFont(ofSize: 10)
        userNameTipLabel.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(userNameField.snp.bottom).offset(4.0)
        }
        
        self.view.addSubview(pwdField)
        pwdField.layer.borderWidth = 1
        pwdField.layer.borderColor = UIColor.black.cgColor
        pwdField.placeholder = "请输入密码"
        pwdField.isSecureTextEntry = true
        pwdField.snp.makeConstraints { make in
            make.top.equalTo(userNameTipLabel.snp.bottom).offset(40.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        
        self.view.addSubview(pwdTipLael)
        pwdTipLael.text = "密码至少为6位组成"
        pwdTipLael.textColor = UIColor.red
        pwdTipLael.font = UIFont.systemFont(ofSize: 10)
        pwdTipLael.snp.makeConstraints { make in
            make.left.right.equalTo(pwdField)
            make.top.equalTo(pwdField.snp.bottom).offset(4.0)
        }
        
        self.view.addSubview(loginButton)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitleColor(UIColor.gray, for: .disabled)
        loginButton.backgroundColor = UIColor.black
        loginButton.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(pwdField.snp.bottom).offset(40.0)
            make.height.equalTo(56.0)
        }
    }
}
