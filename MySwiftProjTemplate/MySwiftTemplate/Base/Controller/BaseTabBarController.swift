//
//  BaseTabBarController.swift
//  swiftProjTemplate
//
//  Created by apple on 27/4/2017.
//  Copyright © 2017 oracleen. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    //MARK:屏幕旋转问题
    override var shouldAutorotate: Bool {
        return (self.selectedViewController?.shouldAutorotate)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.selectedViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.selectedViewController?.preferredInterfaceOrientationForPresentation)!
    }
}
