import UIKit
// 当清除包被释放的时候，清除包内部所有可被清除的资源（Disposable）都将被清除。
//var disposeBag = DisposeBag()
//
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    textField.rx.text.orEmpty
//        .subscribe(onNext: { text in print(text) })
//        .disposed(by: self.disposeBag)
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//
//    self.disposeBag = DisposeBag()
//}
