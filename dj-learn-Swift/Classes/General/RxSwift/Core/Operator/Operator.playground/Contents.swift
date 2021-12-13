import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()


// map
// map 操作符将源 Observable 的每个元素应用你提供的转换方法，然后返回含有转换结果的 Observable。
Observable.of(1, 2, 3)
    .map {
        // 结果会被自动包装成 Observable
        $0 * 10
    }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

// flatMap
// flatMap 操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。
// 这个操作符是非常有用的，例如，当 Observable 的元素本身拥有其他的 Observable 时，你可以将所有子 Observables 的元素发送出来。
let flatMapOb1 = Observable.of(4, 5, 6)
let flatMapOb2 = Observable.of(7, 8)
let flatMapOb3 = Observable.of(9)

let flatMapObservable = Observable.of(flatMapOb1, flatMapOb2, flatMapOb3)

flatMapObservable
    .flatMap({ observaleItem in
        return observaleItem
    })
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
// 打印：4、5、7、6、8、9

flatMapObservable
    .map { observaleItem in
        return observaleItem
    }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
// 打印：三个 ObservableSequence<Swift.Array<Swift.Int>>

/*
 map 和 flatMap 区别
 1、 selector 不同
 2、 子元素
 */
