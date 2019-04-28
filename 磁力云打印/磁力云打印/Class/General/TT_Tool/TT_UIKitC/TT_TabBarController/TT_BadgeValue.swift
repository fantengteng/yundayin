//
//  TT_BadgeValue.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/8.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

public enum TT_BadgeValueType{
    ///  点
    case Point
    ///  new
    case New
    ///  number
    case Number
}

class TT_BadgeValue: UIView {
    
    public var tt:TT_TabBarBadgeValueConfigure? {
        didSet {
            setupSubViewS()
        }
    }
    
    public lazy var badgeL: UILabel = {
        var l = UILabel(frame: .zero)
        l.textColor = tt?.badgeTextColor
        l.font = UIFont.systemFont(ofSize: (tt?.badegeFont)!)
        l.textAlignment = .center
        l.layer.cornerRadius = (tt?.badgelayerRadius)!
        l.layer.masksToBounds = true
        l.backgroundColor = tt?.badgeBackgroundColor
        return l
    }()
    
    public var type: TT_BadgeValueType? {
        didSet {
             setupConfig(type: type!)
        }
    }    
}


extension TT_BadgeValue {
    
    func setupSelfFrame(Frame:CGRect) {
        self.frame = Frame
        self.badgeL.frame = self.bounds
    }
    
    func setupSubViewS () {
        addSubview(badgeL)
    }
    
    func setupConfig(type: TT_BadgeValueType) {
    
        switch type {
        case .Point:
            self.badgeL.layer.cornerRadius = 5.0
            self.badgeL.size = CGSize(width: 10, height: 10)
            self.badgeL.x = 0
            self.badgeL.y = self.height! * 0.5 - (self.badgeL.size?.height)! * 0.5
        case .New:
            self.badgeL.size = CGSize(width: self.width!, height: self.height!)
        case .Number:
            var size:CGSize = CGSize(width: 0, height: 0)
            var radius: CGFloat = 8.0
            if (self.badgeL.text?.count)! <= 1 {
                size = CGSize(width: self.height!, height: self.height!)
                radius = self.height! * 0.5
            }else if (self.badgeL.text?.count)! > 1 {
                size = self.bounds.size
                radius = 8.0
            }
            self.badgeL.size = size
            self.badgeL.layer.cornerRadius = radius
        }
        
        if  tt?.AnimType == .Shake{
            self.badgeL.layer.add(TT_Animation.TT_ShakeAnimation_RepeatTimes(repeaTimes: 5), forKey: "shakeAnimation")
        }else if tt?.AnimType == .Opacity {
            self.badgeL.layer.add(TT_Animation.TT_OpacityAnimationDurTimes(time: 0.3), forKey: "opacityAnimation")
        }else if tt?.AnimType == .Scale {
            self.badgeL.layer.add(TT_Animation.TT_ScaleAnimation(), forKey: "scaleAnimation")
        }
    }
}
