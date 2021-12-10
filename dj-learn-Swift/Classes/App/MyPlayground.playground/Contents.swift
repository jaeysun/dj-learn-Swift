import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport
import SnapKit

class PLController: UIViewController {
    override func viewDidLoad() {
        let userNameField: UITextField = UITextField()
        userNameField.backgroundColor = UIColor.blue
        self.view.addSubview(userNameField)
        userNameField.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.height.equalTo(56)
        }
        
        let label: UILabel = UILabel()
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.equalTo(userNameField)
            make.top.equalTo(userNameField.snp.bottom)
            make.height.equalTo(20)
        }
        label.text = "你好"

        let usernameValid = userNameField.rx.text.orEmpty.map { txt in
            txt.count > 5
        }.share(replay: 1)
        let observer: Binder<Bool> = Binder(label) { (label, isHidden) in
            label.isHidden = isHidden
        }

        usernameValid
            .bind(to: observer)
        
        print("hello playground")

    }
}

let pl = PLController.init()
PlaygroundPage.current.liveView = pl
