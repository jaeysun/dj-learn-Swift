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
        
    let backgrounImageView = UIImageView()
    let userNameField = UITextField()
    let userNameTipLabel = UILabel()
    let pwdField = UITextField()
    let pwdTipLael = UILabel()
    let loginButton = UIButton(type: .custom)
    
    let settingButton = UIButton(type: .custom)
    
    var image: Observable<UIImage>!
    
  
    // 状态序列用 Driver
    var driveEvent: Driver<Void>?
    // 事件序列用 Signal
    var signalEvent: Signal<Void>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 用户名是否有效, 因为有 三个 Observer订阅，所以 share(replay:2) 共享附加作用1次
        let userNameVaild = userNameField.rx.text.orEmpty.map { txt in
            return txt.count > 6
        }.share(replay: 2)
        // 观察者 Binder
        // 用户名是否有效与设置按钮绑定，如果有效，隐藏系统设置按钮
        // hiddenObserver 等价于 settingButton.rx.isHidden
        let hiddenObserver: Binder<Bool> = Binder(settingButton) { (view , isHidden) in
            view.isHidden = isHidden
        }
        userNameVaild.bind(to: hiddenObserver).disposed(by: disposeBag)
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
        
        
        driveEvent =  self.loginButton.rx.tap.asDriver()
        signalEvent = self.loginButton.rx.tap.asSignal()
        // 第一次订阅，登录点击事件
        let dObserver: () -> Void = { self.showAlert("Driver: 弹出提示框1") }
        driveEvent?.drive(onNext: dObserver).disposed(by: disposeBag)
    
        let sObserver: () -> Void = { self.showAlert("Singal: 弹出提示框1") }
        signalEvent?.emit(onNext: sObserver).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe(onNext: {
            print("登录按钮点击")
        }).disposed(by: self.disposeBag)
        
        settingButton.rx.tap.subscribe(onNext: {
            // 第二次订阅，登录点击事件
            // 但是我没有点击，点击“系统设置”按钮前，点击了“登录按钮”，这里订阅了之后，直接就相应了上一次点击事件，就会打印 "弹出提示框2", 不合理。
            // 观察者
            let dirveObserver: () -> Void = { self.showAlert("Driver: 弹出提示框2") }
            self.driveEvent?.drive(onNext: dirveObserver).disposed(by: self.disposeBag)
            
            // 合理的应该是：在这次订阅之后，下次点击按钮时响应，打印 “Singal: 弹出提示框2”
            // 观察者
            let signalObserver: () -> Void = { self.showAlert("Singal: 弹出提示框2") }
            self.signalEvent?.emit(onNext: signalObserver).disposed(by: self.disposeBag)
        })
        .disposed(by: disposeBag)
    }
    
    func showAlert(_ msg: String) {
        print(msg)
    }
    
    override func configSubviews() {
        super.configSubviews()
        
        self.view.addSubview(backgrounImageView)
        backgrounImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
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
        
        self.view.addSubview(settingButton)
        settingButton.setTitle("系统设置", for: .normal)
        settingButton.setTitleColor(UIColor.white, for: .normal)
        settingButton.setTitleColor(UIColor.gray, for: .disabled)
        settingButton.backgroundColor = UIColor.black
        settingButton.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(loginButton.snp.bottom).offset(40.0)
            make.height.equalTo(56.0)
        }
        
    }
}
