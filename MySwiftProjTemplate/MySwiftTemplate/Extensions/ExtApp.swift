//
//  ExtApp.swift
//  MySwiftTemplate
//
//  Created by apple on 5/6/2018.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension UIApplication {
    static var isInUITest: Bool {
        return ProcessInfo.processInfo.environment["isUITest"] != nil;
    }
}
