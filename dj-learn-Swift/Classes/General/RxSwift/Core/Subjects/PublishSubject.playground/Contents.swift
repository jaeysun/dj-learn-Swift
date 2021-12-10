import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

// PublishSubject 将对观察者发送订阅后产生的元素，而在【订阅前发出的元素将不会发送给观察者】。
// 如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。

let disposeBag = DisposeBag()
let subject = PublishSubject<String>()


subject.onNext("1")

subject.subscribe {
    print("Subscription: 1 Event", $0)
}.disposed(by: disposeBag)

subject.onNext("2")
subject.onNext("3")

//subject.onError(NSError(domain: "", code: 110, userInfo: nil))

subject.onCompleted()
