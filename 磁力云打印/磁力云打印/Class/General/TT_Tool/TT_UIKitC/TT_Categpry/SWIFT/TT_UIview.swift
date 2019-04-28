
//
//  TT_UIview.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/9.
//  Copyright © 2018年 FTT. All rights reserved.
//

import Foundation


extension UIView {
    
    public var x: CGFloat? {
        set {
            var frame = self.frame
            frame.origin.x = x!
            self.frame = frame
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat? {
        set {
            var frame = self.frame
            frame.origin.y = y!
            self.frame = frame
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat? {
        set {
            var frame = self.frame
            frame.size.width = width!
            self.frame = frame
        }
        
        get {
            return self.frame.size.width
        }
        
    }
    public var height: CGFloat? {
        set {
            var frame = self.frame
            frame.size.height = height!
            self.frame = frame
        }
        
        get {
            return self.frame.size.height
        }
    }
    public var centerX: CGFloat? {
        set {
            var center: CGPoint = self.center
            center.x = centerX!
            self.center = center
        }
        
        get {
            return self.center.x
        }
    }
    public var centerY: CGFloat? {
        set {
            var center: CGPoint = self.center
            center.y = centerY!
            self.center = center
        }
        
        get {
            return self.center.y
        }
    }
    public var size: CGSize? {
        
        set {
            var frame: CGRect = self.frame
            frame.size = size!
            self.frame = frame
        }
        
        get {
            return self.frame.size
        }
    }
 
    convenience init(frame:CGRect ,lineColor:UIColor) {
        self.init(frame: frame)
        self.backgroundColor = lineColor
    }
}
