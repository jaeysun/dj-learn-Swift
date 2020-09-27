//
//  DJMenuItemCell.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit
import SnapKit
class DJMenuItemCell: UICollectionViewCell {
    
    var iconView: UIImageView!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.configSubviews()
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化布局
    func configSubviews() {
        // 图片
        self.iconView = UIImageView.init()
        self.iconView.contentMode = .scaleAspectFit
        self.iconView.image = UIImage.init(named: "ic_tabbar_other_sel")
        self.contentView.addSubview(self.iconView)
        self.iconView.snp.makeConstraints { (make) in
            make.width.equalTo(self.contentView).multipliedBy(0.5)
            make.height.equalTo(self.contentView).multipliedBy(0.3)
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.centerY).offset(10)
        }
        
        // 标题
        self.titleLabel = UILabel.init()
        self.titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.text = "UIButton"
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.centerY).offset(20)
            make.centerX.equalTo(self.contentView)
        }
    }
}

