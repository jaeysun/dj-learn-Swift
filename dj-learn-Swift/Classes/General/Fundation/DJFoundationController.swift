//
//  DJFoundationController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/8.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class DJFoundationController: DJViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let switchView = DJSwitch(frame: .zero)
//        self.view.addSubview(switchView)
//        switchView.snp.makeConstraints { maker in
//            maker.center.equalTo(self.view)
//            maker.size.equalTo(CGSize(width: 58, height: 32))
//        }
        
        // !隐式解包,  if not nil 解包
        //        DJOptionalDemo.unwrapIfNotNil()
        //        DJOptionalDemo.unwrapIfLet()
        //        DJOptionalDemo.unwrapGuardLet()
        //        // ??
        //        DJOptionalDemo.unwrapEmptyOr()
        //
        //        DJOptionalDemo.optionChain()
        
        
        //       let result1 = DJFunctionDemo.mutiReturn(x: 190.6545, y: 87.13434)
        //        debugPrint(result1)
        //        debugPrint(result1.intX)
        //        debugPrint(result1.intY)
        //        let result2 = DJFunctionDemo.arithmeticMean(1, 8, 1324, 199)
        //        debugPrint(result2)
        //        let values3 = [1, 3.0, 11.3]
        //        let result3 = DJFunctionDemo.arithmeticMean(values3)
        
        //        var valuea = 998
        //        var valueb = 343
        
        //        DJFunctionDemo.swithInt(a: &valuea, b: &valueb)
        //
        //        debugPrint(valuea)
        //        debugPrint(valueb)
        
//        let valueC = DJClosureDemo.trail(valA: 144) { val in
//            "The num is \(val)"
//        }
//        debugPrint(valueC)
        // 如果闭包没有参数， in 可以省略
//        let valueD = DJClosureDemo.trail1(valA: 34) {
//            return 566
//        }
//        debugPrint(valueD)
        // 如果闭包为唯一参数() 可以省略
//        let valueE = DJClosureDemo.trail2 {
//            return 111
//        }
//        debugPrint(valueE)
        
//        var customersInLine = ["Ewa", "Barry", "Daniella"]
        // 将字符串 ”liu“ 转化为 () -> String 类型的闭包
//        DJClosureDemo.serve(customer: "liu")
        
        let button: UIButton =  UIButton(type: .system)
        button.backgroundColor = UIColor.black
        self.view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.center.equalTo(self.view)
            maker.size.equalTo(CGSize(width: 100, height: 40))
        }
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func buttonAction(_ sender: UIButton) {
        let picker = DJTimePickerController(mode: .hourMinute)
        self.present(picker, animated: true, completion: nil)
        picker.pickedClosure =  { year, month, day, hour, mintue in
            print("\(year)年\(month)月\(day)日 \(hour):\(mintue)")
        }
    }
}
