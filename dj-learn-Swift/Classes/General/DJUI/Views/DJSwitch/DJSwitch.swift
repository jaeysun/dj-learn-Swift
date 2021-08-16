//
//  DJSwitch.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/12.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

class DJSwitch: UIView {
    var isOn: Bool = false
    var button: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        button = UIButton(type: .custom)
        let image = UIImage(named: "wp_switch_off")
        button.setBackgroundImage(image, for: .normal)
        let selImage = UIImage(named: "wp_switch_on")
        button.setBackgroundImage(selImage, for: .selected)
        self.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.edges.equalTo(self)
        }
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func buttonAction() {
        button.isSelected = !button.isSelected
    }
    
    
}


