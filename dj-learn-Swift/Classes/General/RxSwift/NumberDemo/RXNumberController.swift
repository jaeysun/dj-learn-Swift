//
//  RXNumberController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/10.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXNumberController: DJViewController {
    
    var numberInput1: UITextField! = UITextField()
    var addLabel1: UILabel! = UILabel()
    var numberInput2: UITextField! = UITextField()
    var addLabel2: UILabel! = UILabel()
    var numberInput3: UITextField! = UITextField()
    var equalSignLabel = UILabel()
    var resultLabel: UILabel! = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // combineLatest 操作符将多个 Observables 中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来。这些源 Observables 中任何一个发出一个元素，他都会发出一个元素（前提是，这些 Observables 曾经发出过元素）。
        // 组合多个 Observable， 任何一个Observable发元素，组合后的Observable都将发出元素
        Observable.combineLatest(numberInput1.rx.text.orEmpty, numberInput2.rx.text.orEmpty, numberInput3.rx.text.orEmpty) {
            (Int($0) ?? 0) + (Int($1) ?? 0) + (Int($2) ?? 0)
        }.map {
            "\($0)"
        }
        .bind(to: self.resultLabel.rx.text)
        .disposed(by: self.disposeBag)
    }
    
    override func configSubviews() {
        super.configSubviews()
        
        addLabel2.text = "+"
        addLabel2.font = UIFont.boldSystemFont(ofSize: 30)
        addLabel2.textAlignment = .center
        self.view.addSubview(addLabel2)
        addLabel2.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 40));
        }
        
        numberInput2.textAlignment = .center
        numberInput2.font = UIFont.boldSystemFont(ofSize: 22)
        numberInput2.borderStyle = .roundedRect
        self.view.addSubview(numberInput2)
        numberInput2.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.bottom.equalTo(addLabel2.snp.top)
        }
        
        addLabel1.text = "+"
        addLabel1.font = UIFont.boldSystemFont(ofSize: 30)
        addLabel1.textAlignment = .center
        self.view.addSubview(addLabel1)
        addLabel1.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.size.equalTo(addLabel2);
            make.bottom.equalTo(numberInput2.snp.top)
        }
        numberInput1.textAlignment = .center
        numberInput1.font = UIFont.boldSystemFont(ofSize: 22)
        numberInput1.borderStyle = .roundedRect
        self.view.addSubview(numberInput1)
        numberInput1.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.size.equalTo(addLabel2);
            make.bottom.equalTo(addLabel1.snp.top)
        }
        numberInput3.textAlignment = .center
        numberInput3.font = UIFont.boldSystemFont(ofSize: 22)
        numberInput3.borderStyle = .roundedRect
        self.view.addSubview(numberInput3)
        numberInput3.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.size.equalTo(addLabel2);
            make.top.equalTo(addLabel2.snp.bottom)
        }
            
        equalSignLabel.text = "="
        equalSignLabel.font = UIFont.boldSystemFont(ofSize: 30)
        equalSignLabel.textAlignment = .center
        self.view.addSubview(equalSignLabel)
        equalSignLabel.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.size.equalTo(addLabel2);
            make.top.equalTo(numberInput3.snp.bottom)
        }
        resultLabel.text = "0"
        resultLabel.font = UIFont.boldSystemFont(ofSize: 30)
        resultLabel.textAlignment = .center
        self.view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.left.right.equalTo(addLabel2)
            make.size.equalTo(addLabel2);
            make.top.equalTo(equalSignLabel.snp.bottom)
        }
    }
}

