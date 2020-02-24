//
//  BaseModel.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class BaseModel {
    
}

extension NSObject {
    //获取所有的属性name数组
    func getAllPropertys()->[String]{
        var result = [String]()
        
        let mir = Mirror(reflecting: self)
        for (key,_) in mir.children {
            result.append(key!)
        }
        
        return result
    }
}
