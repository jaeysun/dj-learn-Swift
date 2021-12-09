//
//  DJViewController.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DJViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        configSubviews()
    }
    
    func configSubviews() {
        
    }
}
