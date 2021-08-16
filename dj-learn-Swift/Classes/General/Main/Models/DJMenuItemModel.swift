//
//  DJMenuItemModel.swift
//  dj-learn-Swift
//
//  Created by Jaesun on 2020/9/22.
//  Copyright © 2020 S.J. All rights reserved.
//

class DJMenuItemModel: DJModel {
    var title:String? = nil
    var imgName:String? = nil
    init(title:String, imgName:String) {
        super.init()
        self.title = title
        self.imgName = imgName
    }
}
