//
//  BaseNavigationController.swift
//  swiftProjTemplate
//
//  Created by apple on 27/4/2017.
//  Copyright © 2017 oracleen. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
    }
    
    //MARK:屏幕旋转问题
    override var shouldAutorotate: Bool {
        return (self.topViewController?.shouldAutorotate)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.topViewController?.preferredInterfaceOrientationForPresentation)!
    }
}
