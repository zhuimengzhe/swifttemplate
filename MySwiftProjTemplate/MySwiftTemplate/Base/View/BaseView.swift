//
//  BaseView.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
}

extension UIView {
    //打印有二义性的约束
    func printAmbiguityConstraints() {
        for vv in self.subviews {
            print("\(vv) \(vv.hasAmbiguousLayout)")
            if vv.subviews.count > 0 {
                vv.printAmbiguityConstraints()
            }
        }
    }
    
    //打印约束
    func printConstraints() {
        for vv in self.subviews {
            let arr1 = vv.constraintsAffectingLayout(for:.horizontal)
            let arr2 = vv.constraintsAffectingLayout(for:.vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", vv, arr1, arr2);
            if vv.subviews.count > 0 {
                vv.printConstraints()
            }
        }
    }
    
    class func animate(times:Int,
                       duration dur: TimeInterval,
                       delay del: TimeInterval,
                       options opts: UIView.AnimationOptions,
                       animations anim: @escaping () -> Void,
                       completion comp: ((Bool) -> Void)?) {
        
        func helper(_ t:Int,
                    _ dur: TimeInterval,
                    _ del: TimeInterval,
                    _ opt: UIView.AnimationOptions,
                    _ anim: @escaping () -> Void,
                    _ com: ((Bool) -> Void)?) {
            
            UIView.animate(withDuration: dur,
                           delay: del,
                           options: opt,
                           animations: anim,
                           completion: {
                            done in
                            if com != nil {
                                com!(done)
                            }
                            if t > 0 {
                                helper(t-1, dur, del, opt, anim, com)
                            }
            })
        }
        helper(times-1, dur, del, opts, anim, comp)
    }
}
