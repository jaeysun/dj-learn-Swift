import UIKit

// 1. 字符串字面量
var greeting = "Hello, playground"



// 2.多行字符串
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

// 3. 判断字符串是否为空
if greeting.isEmpty {
    print("greeting is empty")
} else {
    print("greeting is not empty")
}

// 4. 遍历字符串
for char in greeting {
    print(char)
}

// 5. \(value) 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"


// 6. 字符串索引 String.Index
// 6.1 任何位置的索引
let endIndex = greeting.endIndex
let startIndex = greeting.startIndex
let afterIndex = greeting.index(after: startIndex)
let beforeIndex = greeting.index(before: endIndex)
let off2Index = greeting.index(startIndex, offsetBy: 2)

// 6.1 获取子字符串
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]

// Convert the result to a String for long-term storage.
let newString = String(beginning)

// 6.2 获取字符
for index in 0..<greeting.count {
    let charIndex = greeting.index(greeting.startIndex, offsetBy: index)
    print(greeting[charIndex])
}

// 6.3 插入字符串
greeting.insert("!", at: endIndex)
// 6.4 删除子串
// 返回删除的字符
greeting.remove(at: startIndex)

// 6.5 替换字符串
let hiStr = "Hi"
// 删除前2个字符，返回删除后的字符串
let range = startIndex..<greeting.index(startIndex, offsetBy: hiStr.count)
greeting.removeSubrange(range)
greeting.insert(contentsOf: hiStr, at: startIndex)


// 7. 拼接字符串
greeting.append(" jaesun")

greeting + " and dan"
