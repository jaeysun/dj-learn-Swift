import UIKit

// Switch
// switch 语句会将一个值与多个可能的模式匹配。
// 然后基于第一个成功匹配的模式来执行合适的代码块。
// switch 语句代替 if 语句提供了对多个潜在状态的响应。

/*
 
 switch some value to consider {
 case value 1:
    respond to value 1
 case value 2,
 value 3:
    respond to value 2 or 3
 default:
    otherwise, do something else
 }

 */

// Swift 里的 switch 语句不会默认从每个情况的末尾贯穿到下一个情况里。
// 相反，整个 switch 语句会在匹配到第一个 switch 情况执行完毕之后退出，不再需要显式的 break 语句。
// 如果你确实需要 C 风格的贯穿行为，你可以选择在每个情况末尾使用 fallthrough 关键字
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
