//
//  RSTableController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/16.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RSTableController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView(frame: .zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        // 数据绑定
        Observable.just(0..<100).bind(to: tableView.rx.items, curriedArgument: { (tv, row, element) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "CellIdentifier", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = "第\(row)行元素为：\(element)"
                return cell
            }).disposed(by: disposeBag)
        
        // 点击事件
        tableView.rx.itemSelected.subscribe { indexPath in
            print(indexPath.row)
        }.disposed(by: disposeBag)
        
        
    }
    
}
