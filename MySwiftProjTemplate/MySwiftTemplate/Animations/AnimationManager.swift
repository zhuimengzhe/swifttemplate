//
//  CVLayerView.swift
//  MySwiftTemplate
//
//  Created by apple on 8/12/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class AnimationManager {
    
    enum AnimationStyle {
        case loading //转圈loading
        case radar  //扫描雷达
        case pulse //往外扩散的波
        case wave  //水波
    }
    
    class func animateView(frame:CGRect, style:AnimationStyle) -> UIView {
        switch style {
        case .loading:
            return LoadingView(frame)
        case .pulse:
            return PulseView(frame)
        case .radar:
            return LoadingView(frame)
        case .wave:
            return LoadingView(frame)
        }
    }
}
//加载view
class LoadingView : UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ frame: CGRect) {
        super.init(frame: frame)
        
        let oneCircleRadius: CGFloat = 10
        let animationDuration: Double = 5
        let instanceCount = 20
        
        let animationLayer = CAShapeLayer()
        animationLayer.backgroundColor = UIColor.white.cgColor
        animationLayer.bounds = CGRect(0, 0, oneCircleRadius * 2, oneCircleRadius * 2)
        animationLayer.position = CGPoint(x:self.bounds.size.width/2,y: oneCircleRadius)
        animationLayer.cornerRadius = oneCircleRadius
        animationLayer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        
        let transformAnim = CABasicAnimation(keyPath: "transform")
        transformAnim.duration = animationDuration
        transformAnim.repeatCount = HUGE
        transformAnim.fromValue = CATransform3DMakeScale(1, 1, 1)
        transformAnim.toValue = CATransform3DMakeScale(0.01, 0.01, 0.01)
        animationLayer.add(transformAnim, forKey: nil)
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.bounds
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = animationDuration / Double(instanceCount)
        let angle = CGFloat(Double.pi * 2) / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        replicatorLayer.addSublayer(animationLayer);
        layer.addSublayer(replicatorLayer)
    }
}

class PulseView : UIView {
    init(_ frame:CGRect) {
        super.init(frame: frame)
        let oneCircleRadius: CGFloat = 10
        let animationDuration: Double = 5
        let instanceCount = 20
        
        // 动画图层
        let pulseLayer = CAShapeLayer()
        pulseLayer.backgroundColor = #colorLiteral(red: 0.1551843779, green: 0.7647058964, blue: 0.7637666577, alpha: 1).cgColor
        pulseLayer.bounds = CGRect(0, 0, oneCircleRadius * 2, oneCircleRadius * 2)
        pulseLayer.position = CGPoint(x:self.bounds.size.width/2,y: self.bounds.size.height/2)
        pulseLayer.cornerRadius = oneCircleRadius
        
        // 给CAShapeLayer添加组合动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [getOpacityAnimation(),getScaleAnimation()]
        groupAnimation.duration = animationDuration   //持续时间
        groupAnimation.repeatCount = HUGE
        pulseLayer.add(groupAnimation, forKey:"animationGroup")
        
        // MARK:关键代码
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.bounds
        replicatorLayer.instanceCount = instanceCount // 三个复制图层
        replicatorLayer.instanceDelay = 0.5  // 频率
        replicatorLayer.addSublayer(pulseLayer)
        layer.addSublayer(replicatorLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getOpacityAnimation() -> CABasicAnimation {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0  // 起始值
        opacityAnimation.toValue = 0     // 结束值
        return opacityAnimation
    }
    
    func getScaleAnimation() -> CABasicAnimation {
        //扩散动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.fromValue = CATransform3DMakeScale(1,1,1)
        scaleAnimation.toValue = CATransform3DMakeScale(10, 10, 0)
        return scaleAnimation
    }
}
