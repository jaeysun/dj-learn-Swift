import UIKit
import RxSwift
import RxCocoa

// 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。

let disposeBag = DisposeBag()
let subject = BehaviorSubject(value: "🔴")

subject
  .subscribe { print("Subscription: 1 Event:", $0) }
  .disposed(by: disposeBag)

subject.onNext("🐶")
subject.onNext("🐱")

subject
  .subscribe { print("Subscription: 2 Event:", $0) }
  .disposed(by: disposeBag)

subject.onNext("🅰️")
subject.onNext("🅱️")

subject
  .subscribe { print("Subscription: 3 Event:", $0) }
  .disposed(by: disposeBag)

subject.onNext("🍐")
subject.onNext("🍊")
