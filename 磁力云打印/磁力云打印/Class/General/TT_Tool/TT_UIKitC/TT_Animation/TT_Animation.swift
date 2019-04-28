//
//  TT_Animation.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/9.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

class TT_Animation: CAAnimation {

    
    
    /// 抖动动画
    ///
    /// - Parameter repeaTimes: 重复次数
    /// - Returns: 返回关键帧动画
    class func TT_ShakeAnimation_RepeatTimes(repeaTimes: Float) -> CAKeyframeAnimation {
        let anima: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        anima.values = [angle2Rad(angle: -15),angle2Rad(angle: -10),angle2Rad(angle: -7),angle2Rad(angle: -5),angle2Rad(angle: 0),angle2Rad(angle: 5),angle2Rad(angle: -7),angle2Rad(angle: 10),angle2Rad(angle: 15)]
        anima.repeatCount = repeaTimes
        return anima
    }
    
    
    /// 透明过度动画
    ///
    /// - Parameter time: 持续时间
    /// - Returns: 返回透明过度动画
    class func TT_OpacityAnimationDurTimes(time: Float) -> CABasicAnimation {
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        anima.fromValue = NSNumber(floatLiteral: 1)
        anima.toValue = NSNumber(floatLiteral: 0.2)
        anima.repeatCount = 3
        anima.duration = CFTimeInterval(time)
        anima.autoreverses = true
        return anima
    }
    
    
    /// 缩放动画
    ///
    /// - Returns: 返回缩放动画
    class func TT_ScaleAnimation() -> CABasicAnimation {
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        anima.toValue = NSNumber(floatLiteral: 1.2)
        anima.duration = CFTimeInterval(3)
        anima.autoreverses = true
        return anima
    }
    
    
    /// 旋转动画
    ///
    /// - Parameter rotation: 方向
    /// - Returns: 返回旋转动画
    class func TT_TabBarRotation(rotation: String) -> CABasicAnimation {
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.\(rotation)")
        anim.toValue = NSNumber(floatLiteral: Double.pi * 2)
        return anim
    }
    
    
    /// 上线动画
    ///
    /// - Parameter Point: 到达的点
    /// - Returns: 返回上下移动动画
    class func TT_TabarBoundsMinOrMax(Point:CGPoint) -> CABasicAnimation{
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "bounds.size")
        anim.toValue = NSValue(cgPoint: Point)
        return anim
    }
    
    
    
    class func angle2Rad(angle: Double) -> Double {
        return (angle / 180.0) * Double.pi
    }
}
