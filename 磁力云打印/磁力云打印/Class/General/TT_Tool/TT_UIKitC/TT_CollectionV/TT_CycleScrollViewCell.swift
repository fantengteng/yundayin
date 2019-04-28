
//
//  TT_CycleScrollViewCell.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/18.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit
class TT_CycleScrollViewCell: UICollectionViewCell {
    
    public lazy var imaageView: UIImageView = {
        var imageview = UIImageView(frame: .zero)
        imageview.isUserInteractionEnabled = false
        return imageview
    }()
    
    public var imgCornerRadius:CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViewS()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
}


extension TT_CycleScrollViewCell {
    
   @objc  func setupSubViewS() {
        self.contentView.addSubview(imaageView)
    }
}


extension TT_CycleScrollViewCell {
    
    
    @objc func config(data:AnyObject) {
        
    }
    
    @objc func  configimageinfo(imageNameOrImageURL:String) {
    
    }
}
