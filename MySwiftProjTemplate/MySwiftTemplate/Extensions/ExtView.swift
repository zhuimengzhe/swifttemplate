//
//  ExtView.swift
//  MySwiftTemplate
//
//  Created by apple on 3/1/2018.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

extension UIView {
    //MARK:生成view的倒影
    func invertedView() -> UIView {
        let frame = self.frame
        let reflectionView = UIView.init(frame: frame)
        reflectionView.contentMode = self.contentMode
        reflectionView.transform = reflectionView.transform.scaledBy(x: 1.0, y: -1.0)
        
        let reflectionLayer = reflectionView.layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.bounds = reflectionView.bounds
        gradientLayer.position = CGPoint(x: reflectionLayer.bounds.width*0.5, y: reflectionLayer.bounds.height*0.5)
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.withAlphaComponent(0.3).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        reflectionLayer.mask = gradientLayer
        return reflectionView
    }
    //MARK:添加虚线边框
    func addDashBorder(_ color:UIColor = UIColor.lightGray, radius:CGFloat = 0) {
        let border = CAShapeLayer()
        border.strokeColor = color.cgColor
        border.fillColor = nil
        border.lineDashPattern = [4,2]
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        border.frame = self.bounds
        self.layer.addSublayer(border)
    }
}
