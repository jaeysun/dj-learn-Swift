import UIKit
// 使得订阅一直持续到控制器的 dealloc 事件产生为止
//_ = usernameValid
//    .takeUntil(self.rx.deallocated)
//    .bind(to: passwordOutlet.rx.isEnabled)
//
//_ = usernameValid
//    .takeUntil(self.rx.deallocated)
//    .bind(to: usernameValidOutlet.rx.isHidden)
//
//_ = passwordValid
//    .takeUntil(self.rx.deallocated)
//    .bind(to: passwordValidOutlet.rx.isHidden)
//
//_ = everythingValid
//    .takeUntil(self.rx.deallocated)
//    .bind(to: doSomethingOutlet.rx.isEnabled)
//
//_ = doSomethingOutlet.rx.tap
//    .takeUntil(self.rx.deallocated)
//    .subscribe(onNext: { [weak self] in self?.showAlert() })
//}
