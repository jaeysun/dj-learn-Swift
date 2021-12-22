//
//  RXTableViewSectionedDataSource.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 核心实现 SectionedViewDataSourceType 协议
open class RXTableViewSectionedDataSource<Section: RXSectionModelType>:
    NSObject,
    UITableViewDataSource,
    SectionedViewDataSourceType {
    
    public typealias Item = Section.Item
    
    public typealias ConfigureCell = (RXTableViewSectionedDataSource<Section>, UITableView, IndexPath, Item) -> UITableViewCell
    public typealias TitleForHeaderInSection = (RXTableViewSectionedDataSource<Section>, Int) -> String?
    public typealias TitleForFooterInSection = (RXTableViewSectionedDataSource<Section>, Int) -> String?
        
    open var configureCell: ConfigureCell;
    open var titleForHeaderInSection: TitleForHeaderInSection;
    open var titleForFooterInSection: TitleForFooterInSection;
    
    public init(
        configureCell: @escaping ConfigureCell,
        titleForHeaderInSection: @escaping TitleForHeaderInSection = { _, _ in nil },
        titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil }) {
            self.configureCell = configureCell
            self.titleForHeaderInSection = titleForHeaderInSection
            self.titleForFooterInSection = titleForFooterInSection
        }
    
    public typealias SectionModelSnapshot = RxSectionModel<Section, Item>
    
    // 列表数据
    private var _sectionModels: [SectionModelSnapshot] = []

    open var sectionModels: [Section] {
        _sectionModels.map { Section(original: $0.model, items: $0.items) }
    }

    open subscript(section: Int) -> Section {
        let sectionModel = self._sectionModels[section]
        return Section(original: sectionModel.model, items: sectionModel.items)
    }

    open subscript(indexPath: IndexPath) -> Item {
        get {
            return self._sectionModels[indexPath.section].items[indexPath.item]
        }
        set(item) {
            var section = self._sectionModels[indexPath.section]
            section.items[indexPath.item] = item
            self._sectionModels[indexPath.section] = section
        }
    }

    open func model(at indexPath: IndexPath) throws -> Any {
        self[indexPath]
    }

    open func setSections(_ sections: [Section]) {
        self._sectionModels = sections.map { SectionModelSnapshot(model: $0, items: $0.items) }
    }
    
    // UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        _sectionModels.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard _sectionModels.count > section else { return 0 }
        return _sectionModels[section].items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(indexPath.item < _sectionModels[indexPath.section].items.count)
        return configureCell(self, tableView, indexPath, self[indexPath])
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        titleForHeaderInSection(self, section)
    }
   
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        titleForFooterInSection(self, section)
    }
    
    
}
