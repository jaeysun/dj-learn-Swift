import UIKit

//var disposable: Disposable?
//
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    self.disposable = textField.rx.text.orEmpty
//        .subscribe(onNext: { text in print(text) })
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//    调用 dispose 方法后，订阅将被取消，并且内部资源都会被释放。
//    self.disposable?.dispose()
//}
//
//
