//
//  VCPathTrack.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

final class PathTrackController {
    static let sharedInstance = PathTrackController()
    private init(){}
    
    var lastVc : UIViewController? = nil
    var currentVC: UIViewController? = nil {
        willSet {
            debugPrint("\(#function) \(String(describing: newValue))");
        }
        
        didSet {
            debugPrint("\(#function) \(String(describing: oldValue))");
        }
    }
    
    func shouldTrackVC(vc:UIViewController?) -> Bool {
        var shouldTrack = true
        guard let vc = vc else {
            return false
        }
        
        if vc is UINavigationController || vc is UITabBarController {
            shouldTrack = false
        }else if let navi = vc.parent {
            if navi is UINavigationController || navi is UITabBarController {
                
            }else{
                shouldTrack = false
            }
        }
        
        return shouldTrack
    }
    
    //MARK:追踪VC
    func trackVC(vc:UIViewController, enter:Bool) {
        if shouldTrackVC(vc: vc) {
            if enter {
                currentVC = vc
            }else{
                currentVC = nil
                lastVc = vc
            }
        }
    }
}
