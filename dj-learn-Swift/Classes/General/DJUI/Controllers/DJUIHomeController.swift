//
//  DJUIHomeController.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

import UIKit

class DJUIHomeController: DJViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var menuList: Array<DJMenuItemModel>! = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UI"
        self.configDatas()
        self.configSubviews()
    }
    
    // MARK:- Protocol
    // MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DJMenuItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DJMenuItemCell", for: indexPath) as! DJMenuItemCell
        cell.model = self.menuList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 2)/3.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let vc = DJUILabelController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = RXImagePickerController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = RXNumberController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = RXSimpleValidController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            return
        }
    }
    
    // MARK:- 视图初始化
    override func configSubviews() {
        let layout = UICollectionViewFlowLayout.init()
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.lightGray
        self.collectionView.bounces = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView .register(DJMenuItemCell.self, forCellWithReuseIdentifier: "DJMenuItemCell")
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func configDatas() {
        // UILabel
        let labelModel = DJMenuItemModel.init(title: "UILabel", imgName: "icon_uilabel")
        menuList.append(labelModel)
        // 图片选择器
        let imagePickerModel = DJMenuItemModel.init(title: "Image Picker", imgName: "icon_uilabel")
        menuList.append(imagePickerModel)
        // 加法
        let numberModel = DJMenuItemModel.init(title: "Number", imgName: "icon_uilabel")
        menuList.append(numberModel)
        // RxSwift 简单验证
        let sampleVaildModel = DJMenuItemModel.init(title: "Sample Vaild", imgName: "icon_uilabel")
        menuList.append(sampleVaildModel)
        for index in 0...15 {
            let itemModel = DJMenuItemModel.init(title: "Item:\(index)", imgName: "icon_uilabel")
            menuList.append(itemModel)
        }
    }
}
