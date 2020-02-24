//
//  ConvenienceTools.swift
//  MySwiftTemplate
//
//  Created by apple on 4/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

//从哪个viewcontroller弹出一个 alert出来
public func alert(controller:UIViewController!, message:String!) {
    let alertView = UIAlertController(title: "温馨提示",
                                      message: message,
                                      preferredStyle: .alert)
    controller.present(alertView, animated: true) {
        debugPrint("has alerted")
    }
}

//打印错误日志 比较全面
public func printLog<T>(_ message:T,
                        file:String = #file,
                        method:String = #function,
                        line:Int = #line,
                        column:Int = #column) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

//包装 多线程 同步方法
func synchronized(lock:AnyObject,closure:()->()) {
    //进入同步block
    objc_sync_enter(lock)
    closure()
    //退出同步block
    objc_sync_exit(lock)
}

//获取一个随机数
func randomInRange(range:Range<Int>) -> Int {
    let count = UInt32(range.upperBound  - range.lowerBound)
    return Int(arc4random_uniform(count)) + range.lowerBound
}

//交换两个数
func swapMe<T>(a:inout T, b:inout T) {
    (a,b) = (b,a)
}
