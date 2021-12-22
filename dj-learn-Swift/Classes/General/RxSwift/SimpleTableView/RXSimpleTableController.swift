//
//  RXSimpleTableController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/12/20.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RXSimpleTableController: DJViewController {
    
    var tableView: UITableView! = UITableView.init(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just(
            (0..<20).map({ "\($0)"})
        )
        // DataSource 数据源
        items.bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text =  "\(element) @ row \(row)"
        }.disposed(by: disposeBag)
        
        // 点击事件
        tableView.rx.modelSelected(String.self)
            .subscribe (onNext:  {value in
                let alertView = UIAlertController(title: "RxExample", message: "Tap \(value)", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                })
                self.present(alertView, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
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
