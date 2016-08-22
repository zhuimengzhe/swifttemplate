//
//  ExtensionCG.swift
//  Guide
//
//  Created by apple on 4/18/16.
//  Copyright © 2016 dingmc. All rights reserved.
//

import UIKit
//MARK:CGRect extension

extension CGRect {
    //取 矩形 内嵌的一个矩形
    static func frameCenterIn(rect : CGRect, withSize size : CGSize) -> CGRect {
        return CGRect(x: (rect.width - size.width) / 2 + rect.origin.x, y: (rect.height - size.height) / 2 + rect.origin.y, width: size.width, height: size.height)
    }
    
    //取 矩形内嵌的一个 正方形
    static func frameCenterIn(rect : CGRect, withWidth width : CGFloat) -> CGRect {
        return CGRect.frameCenterIn(rect, withSize: CGSize(width: width, height: width))
    }
}

//scale为按原尺寸大小
//MARK:CGFloat extension
extension CGFloat{
    func Fit6() -> CGFloat{
        return self * scale6
    }
}
//MARK:Double extension
extension Double{
    func Fit6() -> CGFloat{
        return CGFloat(self) * scale6
    }
}
//MARK:Int extension
extension Int{
    func Fit6() -> CGFloat{
        return CGFloat(self) * scale6
    }
}
