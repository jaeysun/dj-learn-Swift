//
//  RXSectionModelType.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//


import Foundation

public protocol RXSectionModelType {
    associatedtype Item

    var items: [Item] { get }

    init(original: Self, items: [Item])
}
