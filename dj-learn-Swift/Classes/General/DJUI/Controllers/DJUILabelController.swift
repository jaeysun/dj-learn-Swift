//
//  DJUILabelController.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/27.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

class DJUILabelController: DJViewController {

    var defaultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultLabel = UILabel.init()
        defaultLabel.backgroundColor = UIColor.lightGray
        defaultLabel.text = "更改背景色"
        self.view .addSubview(defaultLabel)
        defaultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(50)
            make.top.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-50)
            make.height.equalTo(40)
        }
    }
    
    
    
}
