//
//  BaseTableView.swift
//  MySwiftTemplate
//
//  Created by apple on 6/12/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    //为了解决可能的视频播放slider和scrollview手势冲突的问题
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UISlider {
            return false
        }
        return true
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
            self.estimatedRowHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.estimatedSectionFooterHeight = 0
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
