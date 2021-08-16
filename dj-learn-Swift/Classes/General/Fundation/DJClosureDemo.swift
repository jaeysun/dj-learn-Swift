//
//  DJClosureDemo.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/9.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class DJClosureDemo: NSObject {
    var closure1: ((Int) -> Void)?
    
    // 一、闭包是引用类型
    
        
    //    { (parameters) -> (return type) in
    //        statements
    //    }
        

    // 二、尾随闭包
    // 闭包作为函数的最后一个参数
    // 尾随闭包是一个被书写在函数形式参数的括号外面（后面）的闭包表达式，但它仍然是这个函数的实际参数
    static func trail(valA: Int, closure:(Int) -> String) -> String {
        let valB = closure(valA)
        return valB
    }
    // 如果闭包没有参数， in 可以省略
    static func trail1(valA: Int, closure: () -> Int) -> Int {
        let valB = closure()
        return valA + valB
    }
    // 如果闭包为唯一参数，() 可以省略
    static func trail2(closure: () -> Int) -> Int {
        let valB = closure()
        return valB
    }
    
    // 三、逃逸闭包 @escaping
    // 当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它是在[函数返回之后调用]的。
    // 当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写 @escaping 来明确闭包是允许逃逸的。
    // 闭包可以逃逸的一种方法是被储存在定义于函数外的变量里。比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。
    // 函数在启动任务后返回，但是闭包要直到任务完成——闭包需要逃逸，[以便于稍后调用]。

    static var completionHandlers: [() -> Void] = []
    static func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    // 四、自动闭包
    // 将表达式转化为闭包
    static func serve(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
    }
 

}
