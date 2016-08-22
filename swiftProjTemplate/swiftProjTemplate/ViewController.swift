//
//  ViewController.swift
//  swiftProjTemplate
//
//  Created by apple on 8/5/16.
//  Copyright © 2016 oracleen. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: BaseViewController {
    
    var myvar:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////使用默认的数据库
        //let realm = try! Realm()
        ////查询所有的消费记录
        //let items = realm.objects(ConsumeItem)
        ////已经有记录的话就不插入了
        //if items.count > 0 {
        //return
        //}
        
        ////创建两个消费类型
        //let type1 = ConsumeType()
        //type1.name = "购物"
        //let type2 = ConsumeType()
        //type2.name = "娱乐"
        
        ////创建3个消费记录
        //let item1 = ConsumeItem(value: ["买一台电脑",5599.9,NSDate(),type1])//可使用数组创建
        
        //let item2 = ConsumeItem()
        //item2.name = "看一场电影"
        //item2.cost =  30.0
        //item2.date = NSDate(timeIntervalSinceNow: -72000)
        //item2.type = type2
        
        //let item3 = ConsumeItem()
        //item3.name = "买一包泡面"
        //item3.cost = 2.50
        //item3.date = NSDate(timeIntervalSinceNow: -35000)
        //item3.type = type1
        
        ////数据持久化操作
        //try! realm.write{
        //realm.add(item3)
        //realm.add(item2)
        //realm.add(item1)
        //}
        ////打印出数据库地址
        //print(realm.configuration.fileURL)
    }
}



//消费类型
class ConsumeType : Object {
    //类型名
    dynamic var name = ""
}

//消费条目
class ConsumeItem : Object {
    //条目名
    dynamic var name = ""
    //金额
    dynamic var cost = 0.00
    //时间
    dynamic var date = NSDate()
    //所属消费类别
    dynamic var type:ConsumeType?
}
