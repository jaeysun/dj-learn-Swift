//
//  RxTableViewSectionedReloadDataSource.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

open class RxTableViewSectionedReloadDataSource<Section: RXSectionModelType>
    : RXTableViewSectionedDataSource<Section>, RxTableViewDataSourceType {
    
    public typealias Element = [Section]
    
    open func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        Binder(self) { dataSource, element in
            dataSource.setSections(element)
            tableView.reloadData()
        }.on(observedEvent)
    }
}
