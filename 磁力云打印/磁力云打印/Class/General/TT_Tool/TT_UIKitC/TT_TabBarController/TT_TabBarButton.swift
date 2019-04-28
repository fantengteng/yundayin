//
//  TT_TabBarButton.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/8.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

class TT_TabBarButton: UIView {

    public var imageView: UIImageView?
    
    public var title: UILabel?
    
    public var tt:TT_TabButtonConfigure? {
        didSet {
             setupSubViewS()
        }
    }
    
    public var BadgeValueConfigure:TT_TabBarBadgeValueConfigure? {
        didSet {
            badgeValue?.tt = BadgeValueConfigure!
        }
    }
    
    public var typeLayout: TT_TabBarButtonType? {
        didSet {
            setupConfig(typeLayout: typeLayout!)
        }
    }
    
    public var badgeValue: TT_BadgeValue?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGSize = (tt?.imageSiez)!
        var imageY:CGFloat = (tt?.imageOffset)!
        if (tt?.typeLayout)! == .Image {
            imageY = self.height! * 0.5 - imageSize.height * 0.5
        }
        let imageX: CGFloat = self.width! * 0.5 - imageSize.width * 0.5
        self.imageView?.frame = CGRect(x: imageX, y: imageY, width: imageSize.width, height: imageSize.height)
        
        let titleX: CGFloat = 4
        let titleH: CGFloat = 14
        let titleW: CGFloat = self.width! - 8
        let titleY: CGFloat = self.height! - titleH - (tt?.titleOffset)!
        self.title?.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        
        let badgeX: CGFloat = (self.imageView?.frame.maxX)! - 6
        let badgeY: CGFloat = (self.imageView?.frame.origin.y)! - 6
        let badgeH: CGFloat = 16
        let badgeW: CGFloat = 16
        self.badgeValue?.setupSelfFrame(Frame: CGRect(x: badgeX, y: badgeY, width: badgeW, height: badgeH))
    }
    
}


extension TT_TabBarButton {
    
    func setupSubViewS() {
        imageView = UIImageView()
        self.addSubview(imageView!)
        
        title = UILabel()
        title?.textAlignment = .center
        title?.font = UIFont.systemFont(ofSize: (tt?.titleFont)!)
        self.addSubview(title!)
      
        badgeValue = TT_BadgeValue()
        badgeValue?.isHidden = true
        self.addSubview(badgeValue!)
        typeLayout = tt?.typeLayout
    }
    
    
    func setupConfig(typeLayout: TT_TabBarButtonType) {
        if typeLayout == .Image {
            self.title?.isHidden = true
            let imageSize: CGSize = (tt?.imageSiez)!
            let imageX: CGFloat = self.width! * 0.5 - imageSize.width * 0.5
            let imageY: CGFloat = self.height! * 0.5 - imageSize.height * 0.5
            self.imageView?.frame = CGRect(x: imageX, y: imageY, width: imageSize.width, height: imageSize.height)
        }
    }
}

