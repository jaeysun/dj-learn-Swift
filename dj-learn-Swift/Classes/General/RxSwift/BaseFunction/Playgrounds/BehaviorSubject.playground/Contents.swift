import UIKit
import RxSwift
import RxCocoa

// ReplaySubject 将对观察者发送全部的元素，无论观察者是何时进行订阅的。

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
