//
//  ViewController.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/22.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var viewModel: ViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.identifier)
        tableView.refreshControl = refreshControl
        
        viewModel.showErrorMessage
            .emit(onNext: { [weak self] message in
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
        })
            .disposed(by: disposeBag)
        
        viewModel.fetchCompleted
            .emit(onNext: { [weak self] in
                self?.refreshControl.endRefreshing()
                self?.tableView.setContentOffset(CGPoint.zero, animated: true)
            })
            .disposed(by: disposeBag)
        
        let dataSource = DataSource()
        viewModel.model
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.viewDidLoad.accept(())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.refresh)
            .disposed(by: disposeBag)
    }
    
    class DataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
        
        typealias Element = GithubRepositoryModel
        var items: [GithubRepositoryModel.Item] = []
        
        func tableView(_ tableView: UITableView, observedEvent: Event<GithubRepositoryModel>) {
            if case .next(let model) = observedEvent {
                items = model.items
                tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
            let item = items[indexPath.row]
            cell.config(model: item)
            return cell
        }
    }
}
