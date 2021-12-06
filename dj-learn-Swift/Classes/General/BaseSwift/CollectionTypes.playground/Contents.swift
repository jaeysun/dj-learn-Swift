import UIKit

// Swift 中的 Array、Set、Dictionary 都是通过 Generic 集合实现的
// 一、数组（Array)
// 1、创建数组
var months = [Int](1...12) // ... 区间语法创建数组
var someInts = [Int]() // 空数组

// 2、遍历数组

// 2.1 enumerated 遍历其中的索引和数据

for (index, value) in months.enumerated() {
    print("Item \(index + 1): \(value)")
}


// 二、合集 （Set)
// 合集将同一类型且不重复的值无序地储存在一个集合当中。
// 当元素的顺序不那么重要的时候你就可以使用合集来代替数组，或者你需要确保元素不会重复的时候。

// 1、创建合集
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// prints "letters is of type Set<Character> with 0 items."
letters.insert("b")
print(letters)
let numbers = Set.init(arrayLiteral: months) // 通过数组创建集合
print(numbers)

// 2、基本合集操作
var lettersA:Set<Character> = ["A", "b", "C", "z"]
var lettersB:Set<Character> = ["A", "c", "C", "e", "F", "D"]
// 2.1 交
let letterInters = lettersA.intersection(lettersB)
// 2.2 并
let letterUnion = lettersA.union(lettersB)
// 2.3 补
let letterSymmetricDi = lettersA.symmetricDifference(lettersB)
// 2.4 差
let letterSub = lettersB.subtracting(lettersA)

// 三、字典（Dictionary）
var namesOfIntegers = [Int : String]()
namesOfIntegers = [1 : "jaesun", 2 : "is"]

// 修改字典
var airports = [String : String]()
airports["LHR"] = "London Heathrow"
airports.updateValue("Beijing", forKey: "DUB")

if airports.removeValue(forKey: "DUB") != nil {}

// 遍历字典
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
