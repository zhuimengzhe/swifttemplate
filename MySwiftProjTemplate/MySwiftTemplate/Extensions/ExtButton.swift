
//
//  ExtButton.swift
//  MySwiftTemplate
//
//  Created by apple on 25/10/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

enum ButtonImageTitleStyle {
    case `default`      //图片在左, 文字在右 整体居中
    case left           //图片在左, 文字在右 整体居中
    case right          //图片在右, 文字在左 整体居中
    case top            //图片在上, 文字在下 整体居中
    case bottom         //图片在下, 文字在上 整体居中
    
    case centerTop      //图片在左, 文字在右 整体居中
    case centerBottom
    case centerUp
    case centerDown
    
    case rightLeft
    case leftRight
}

extension UIButton {
    //上面图片 下面label
    func topImageBottomTitle(spacing:CGFloat = 0) {
        guard imageView != nil && titleLabel != nil else {
            //            AlertInstance.showHud(KeyWindow, str: "button需要已经设置图片")
            return
        }
        
        let imageHeight =  imageView!.frame.height
        let titleHeight = titleLabel!.frame.height
        let titleWidth = titleLabel!.frame.width
        let imageWidth = imageView!.frame.width
        
        let totalHeight = imageHeight + titleHeight + spacing
        
        imageEdgeInsets = UIEdgeInsets(top: imageHeight - totalHeight, left: 0.0, bottom: 0.0,right: 0 - titleWidth)
        titleEdgeInsets = UIEdgeInsets(top: 0,left: 0 - imageWidth,bottom: titleHeight - totalHeight, right: 0.0)
    }
    
    //上面title 下面 image
    func topTitleBottomImage(spacing:CGFloat = 0) {
        guard imageView != nil && titleLabel != nil else {
            //            AlertInstance.showHud(KeyWindow, str: "button需要已经设置图片")
            return
        }
        
        let imageHeight =  imageView!.frame.height
        let titleHeight = titleLabel!.frame.height
        let titleWidth = titleLabel!.frame.width
        let imageWidth = imageView!.frame.width
        
        let totalHeight = imageHeight + titleHeight + spacing
        
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: imageHeight - totalHeight, right: 0 - titleWidth)
        titleEdgeInsets = UIEdgeInsets.init(top: titleHeight - totalHeight, left: 0 - imageWidth, bottom: 0, right: 0)
    }
    
    //左边label 右边 image
    func leftLabelRightImage(spacing:CGFloat = 0) {
        guard imageView != nil && titleLabel != nil else {
            //            AlertInstance.showHud(KeyWindow, str: "button需要已经设置图片")
            return
        }
        
        let titleWidth = titleLabel!.frame.width
        let imageWidth = imageView!.frame.width
        
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleWidth + spacing / 2, bottom: 0, right: -(titleWidth + spacing / 2))
        
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageWidth + spacing / 2), bottom: 0, right: imageWidth + spacing / 2)
    }
    
    //左边image 右边label
    func leftImageRightLabel(spacing:CGFloat = 0) {
        guard imageView != nil && titleLabel != nil else {
            //            AlertInstance.showHud(KeyWindow, str: "button需要已经设置图片")
            return
        }
        
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing / 2, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -spacing / 2)
    }
}
