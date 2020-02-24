//
//  BaseTableViewController.swift
//  MySwiftTemplate
//
//  Created by apple on 31/10/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    
    public var tableView: UITableView
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: boxView.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 11.0, *) {
            tableView.separatorInsetReference = .fromCellEdges
            tableView.estimatedRowHeight = CGFloat(0)
            tableView.estimatedSectionFooterHeight = CGFloat(0)
            tableView.estimatedSectionHeaderHeight = CGFloat(0)
        }
        boxView.addSubview(tableView)
    }
}

//MARK: UITableViewData&UITableViewDelegate
extension BaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BaseTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
