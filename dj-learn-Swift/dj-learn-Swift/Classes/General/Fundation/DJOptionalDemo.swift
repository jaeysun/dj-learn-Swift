//
//  DJOptionalDemo.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/8.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class DJOptionalDemo: NSObject {

    // 一、 可选项
    static var optionalValue1: String?
    
    // 解包方式1、 隐式展开可选项解包, !
    static func unwrapIfNotNil() {
        optionalValue1 = "this is a good f"
        if optionalValue1 != nil {
            let unwrapValue = optionalValue1!
            debugPrint(unwrapValue)
        }
    }
    
    // 解包方式2、 可选项绑定解包，if let
    static func unwrapIfLet() {
        optionalValue1 = "this is a good f"
        if let unwrapValue = optionalValue1 {
            debugPrint(unwrapValue)
        }
    }
    
    // 解包方式3、可选项绑定解包， guard let
    static func unwrapGuardLet() {
        optionalValue1 = "this is a good f"
        guard let unwrapValue = optionalValue1 else { return }
        debugPrint(unwrapValue)
    }
    
    // 解包方式4、 空合并运算符解包， ?? 后为相同存储类型的非可选值
    // 示例：a ?? b
    // a：必须是可选项
    // b：可选项 或者 不是可选项
    // b和a的存储类型必须相同
    // ?? 运算结果，是否为可选类型与??后边的数据一直，如果
    static func unwrapEmptyOr() {
        optionalValue1 = "this is a good f"
        let optionalValue2: String = ""
        let unwrapValue = optionalValue1 ?? optionalValue2
        debugPrint(unwrapValue)
    }
    
    // 二、可选链
    class Person {
        var residence: Residence?
    }
     
    class Residence {
        var numberOfRooms = 1
    }
    
    
    // 你可以通过在你希望如果可选项为非 nil 就调用属性、方法或者脚本的可选值后边使用问号（ ? ）来明确可选链
    static func optionChain() {
        let john = Person()
        john.residence = Residence()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // Prints "Unable to retrieve the number of rooms."
    }
    
    
}
