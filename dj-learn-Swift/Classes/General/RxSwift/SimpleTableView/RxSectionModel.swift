//
//  RxSectionModel.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

public struct RxSectionModel<Section, ItemType> {
    public var model: Section
    public var items: [Item]

    public init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension RxSectionModel
    : RXSectionModelType {
    public typealias Identity = Section
    public typealias Item = ItemType
    
    public var identity: Section {
        model
    }
}

extension RxSectionModel
    : CustomStringConvertible {

    public var description: String {
        "\(self.model) > \(items)"
    }
}

extension RxSectionModel {
    public init(original: RxSectionModel<Section, Item>, items: [Item]) {
        self.model = original.model
        self.items = items
    }
}
