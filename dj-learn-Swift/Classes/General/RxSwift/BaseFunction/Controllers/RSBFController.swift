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

struct UserViewModel {
    //用户名
    let username = BehaviorRelay<String>(value: "gust")
     
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
    
    
}

class RSBFController: UIViewController {
    
    typealias JSON = Any
    var json: Observable<JSON>?
    
    var txtSub = PublishSubject<String>() //类成员变量里面定义序列
    var disposeBag = DisposeBag()
    var userVM = UserViewModel()
    
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
            print("UIButton 点击事件")
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
        
        
        // UITextField 文本响应
        let textField2 = UITextField()
        self.view.addSubview(textField2)
        textField2.layer.borderWidth = 1
        textField2.layer.borderColor = UIColor.black.cgColor
        textField2.placeholder = "UITextField 文本响应"
        textField2.textAlignment = .center
        textField2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(30.0)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40.0)
        }
        textField2.rx.text.orEmpty.subscribe { text in
            label1.text = text.element
        }.disposed(by: disposeBag)
        
        
        
        // 双向绑定
        userVM.username.asObservable().bind(to: textField1.rx.text).disposed(by: disposeBag)
        textField1.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
        
        // 通知
        NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .subscribe(onNext: { (notification) in
                print("Application Will Enter Foreground")
            })
            .disposed(by: disposeBag)
        
        self.observableCreateUse()
        if let json = self.json {
            json.subscribe(onNext: { value in
                print("success message is \(value)")
            }, onError: { error in
                print("error: \(error.localizedDescription)")
            }, onCompleted: {
                print("onCompleted")
            }).disposed(by: self.disposeBag)
        }
        
        // Singal
        self.signal.subscribe { data in
            print(data)
        } onFailure: { error in
            print(error)
        }.disposed(by: self.disposeBag)
        
        // Completable
        self.complete.subscribe {
            print("Completable complete")
        } onError: { error in
            print(error)
        }.disposed(by: self.disposeBag)
    
        
    }

    /// 通过 token 取得用户信息
    static func userinfo(token: String,
        success: (String) -> Void,
        failure: (Error) -> Void) {
        success("OK->HelloWorld")
    }
    
    
    func network(success: ((String) -> Void)?, failure: ((Error) -> Void)?) {
        // 创建并行队列，尽量用自定义队列，免得自己的代码质量不过关，影响全局队列
        let queue = DispatchQueue(label: "com.apple.request", attributes: .concurrent)
        // 异步执行
        queue.async {
            sleep(3)//模拟网络请求
//            guard let complete = success else  { return }
//            complete("数据请求成功")
            
            guard let complete = failure else  { return }
            let error = NSError(domain: "数据请失败", code: 100, userInfo: ["msg": "数据请失败"])
            complete(error)
        }
    }
    
    // 一、创建序列
    // 1、Observable.create
    let numbers: Observable<Int> = Observable.create { observer -> Disposable in
        observer.onNext(1)
        observer.onNext(2)
        observer.onNext(3)
        observer.onNext(4)
        observer.onNext(5)
        observer.onCompleted()
        return Disposables.create()
    }
    
    func observableCreateUse() {
        typealias JSON = Any
        self.json = Observable.create { (observer) -> Disposable in
            self.network { msg in
                observer.onNext(msg)
                observer.onCompleted()
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    public enum Event<Element> {
        case next(Element)
        case error(Swift.Error)
        case completed
    }

    
    // Signal
    // 发出一个元素，或一个 error 事件
    let signal = Single<[String: Any]>.create { signal in
        sleep(10)
        signal(.success(["data": "success"]))
        
        let error = NSError(domain: "", code: 1000, userInfo: ["message":"error"])
        signal(.failure(error))
        
        return Disposables.create()
    }
    
    // Completable
    // 发出零个元素
    // 发出一个 completed 事件或者一个 error 事件
    let complete = Completable.create { completable in
       
        let error = NSError(domain: "", code: 1000, userInfo: ["message":"completable error"])
        completable(.error(error))
        
//        completable(.completed)
        
        return Disposables.create()
     }
}


