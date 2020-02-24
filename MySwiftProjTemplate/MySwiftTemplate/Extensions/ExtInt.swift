//
//  ExtInt.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
//MARK:扩展 Int
extension Int {
    subscript(index: Int) -> Int {
        get {
            let s = String(self)
            return Int(String(s[s.index(s.startIndex, offsetBy:index)]))!
        }
        set {
            var s = String(self)
            let i = s.index(s.startIndex, offsetBy:index)
            s.replaceSubrange(i...i, with: String(newValue))
            self = Int(s)!
        }
    }
}
