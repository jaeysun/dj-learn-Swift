//
//  DJFunctionDemo.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/9.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class DJFunctionDemo: NSObject {
//    1 定义和调用函数
    
//    2 函数的形式参数和返回值
//        2.1 无形式参数的函数
//        2.2 多形式参数的函数
//        2.3 无返回值的函数
//        2.4 多返回值的函数
    // 多返回值函数，其实就是返回一个元祖
    static func mutiReturn(x: Float, y: Float) -> (intX: Int, intY: Int) {
        return (Int(x), Int(y))
    }
//        2.5 可选元组返回类型
//        2.6 隐式返回的函数
//            如果整个函数体是一个单一表达式，那么函数隐式返回这个表达式
//    3 函数实际参数标签和形式参数名
//        3.1 指定实际参数标签
//        3.2 省略实际参数标签
//        3.3 默认形式参数值
//        3.4 可变形式参数
//    可变形式参数可以接受零或者多个特定类型的值。当调用函数的时候你可以利用可变形式参数来声明形式参数可以被传入值的数量是可变的。可以通过在形式参数的类型名称后边插入三个点符号（ ...）来书写可变形式参数。
   static func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
//        3.5 输入输出形式参数
//     如果你想函数能够修改一个形式参数的值，而且你想这些改变在函数结束之后依然生效，那么就需要将形式参数定义为输入输出形式参数
    static func swithInt(a: inout Int, b: inout Int) {
        b = a ^ b
        a = a ^ b
        b = a ^ b
    }
    
//    4 函数类型
//        4.1 使用函数类型
//        4.2 函数类型作为形式参数类型
//        4.3 函数类型作为返回类型
//    5 内嵌函数
}
