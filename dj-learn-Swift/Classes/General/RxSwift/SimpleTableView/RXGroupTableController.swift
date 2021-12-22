//
//  RXGroupTableController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class RXGroupTableController: DJViewController {
    // 视图
    var tableView: UITableView! = UITableView(frame: .zero, style: .grouped)
    
    // 数据源
    let dataSource = RxTableViewSectionedReloadDataSource<RxSectionModel<String, Double>>(configureCell: { _, tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
        return cell
    }, titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    }, titleForFooterInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = dataSource
        
        let items = Observable.just([
            RxSectionModel(model: "First Section", items: [
                1.1,
                1.2,
                1.3
            ]),
            RxSectionModel(model: "First Section", items: [
                2.1,
                2.2,
                2.3
            ]),
            RxSectionModel(model: "First Section", items: [
                3.1,
                3.2,
                3.3
            ]),
        ])
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    override func configSubviews() {
        super.configSubviews()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}
