//
//  ExtTableView.swift
//  MySwiftTemplate
//
//  Created by apple on 28/5/2018.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView.init(frame: .zero)
    }
}
