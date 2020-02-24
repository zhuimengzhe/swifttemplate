//
//  SwizzlingInitialize.swift
//  MySwiftTemplate
//
//  Created by apple on 4/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
// MARK: 自省协议
protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}

// MARK: swizzling交换方法
public func swizzleMethod(_ forClass:Swift.AnyClass,
                          instance:Bool = true,
                          originalSelector:Selector,
                          swizzledSelector:Selector) {
    let originalMethod0 : Method?
    let swizzledMethod0 : Method?
    if instance {
        originalMethod0 = class_getInstanceMethod(forClass, originalSelector)
        swizzledMethod0 = class_getInstanceMethod(forClass, swizzledSelector)
    }
    else {
        originalMethod0 = class_getClassMethod(forClass, originalSelector)
        swizzledMethod0 = class_getClassMethod(forClass, swizzledSelector)
    }
    
    guard let originalMethod = originalMethod0, let swizzledMethod = swizzledMethod0 else {
        print("the both methods has one noimplement at least")
        return
    }
    
    //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
    let didAddMethod: Bool = class_addMethod(forClass,
                                             originalSelector,
                                             method_getImplementation(swizzledMethod),
                                             method_getTypeEncoding(swizzledMethod))
    
    //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
    if didAddMethod {
        class_replaceMethod(forClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod))
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
