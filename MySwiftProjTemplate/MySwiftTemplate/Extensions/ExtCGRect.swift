//
//  ExtCGRect.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
//MARK:扩展 CGRect
extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
    
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
    
    var left : CGFloat {
        get {
            return self.minX
        }
        set {
            var oldFrame = self
            oldFrame.origin.x = newValue
            self = oldFrame
        }
    }
    
    var right : CGFloat {
        get {
            return self.maxX
        }
        set {
            var oldFrame = self
            oldFrame.size.width = newValue - oldFrame.minX
            self = oldFrame
        }
    }
    
    var top : CGFloat {
        get {
            return self.minY
        }
        set {
            var oldFrame = self
            oldFrame.origin.y = newValue
            self = oldFrame
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.maxY
        }
        set {
            var oldFrame = self
            oldFrame.size.height = newValue - oldFrame.minY
            self = oldFrame
        }
    }
    
    var leftTopPoint : CGPoint {
        return self.origin
    }
    
    var leftBottomPoint : CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    
    var rightTopPoint : CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    
    var rightBottomPoint : CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
}
