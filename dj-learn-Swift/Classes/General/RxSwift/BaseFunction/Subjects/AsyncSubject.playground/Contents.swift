import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()
// AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），
// 如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。
// 如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
let subject = AsyncSubject<String>()

subject.subscribe {
    print("Subscription: 1 Event:", $0)
  }.disposed(by: disposeBag)

subject.onNext("🐶")
subject.onNext("🐱")
subject.subscribe {
    print("Subscription: 2 Event:", $0)
  }.disposed(by: disposeBag)

subject.onNext("🐹")

//subject.onError(NSError(domain: "error", code: -999, userInfo: ["msg":"error msg"]))

subject.onCompleted()






