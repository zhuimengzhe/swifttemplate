//
//  BaseViewControllerWithTableView.swift
//  swiftProjTemplate
//
//  Created by apple on 8/8/16.
//  Copyright © 2016 oracleen. All rights reserved.
//

import UIKit

public class BaseViewControllerWithTableView: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let cellIden = "baseviewtab"
    let tableView = UITableView()
    var datas : [AnyObject]?
    
    public func headerLoadData() {
        requestData()
    }
    
    public func footerLoadData() {
        requestData()
    }
    
    public func requestData() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) { 
            //停止刷新
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins =  UIEdgeInsetsZero
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableView.self, forCellReuseIdentifier: cellIden)
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if datas?.count == 0 {
            //tablefooter beginrefreshing
        }
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datas?.count)!
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIden, forIndexPath: indexPath)
        return cell
    }
}
