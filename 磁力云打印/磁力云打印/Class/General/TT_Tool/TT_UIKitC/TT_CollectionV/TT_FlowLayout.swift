//
//  TT_FlowLayout.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/18.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

class TT_FlowLayout: UICollectionViewFlowLayout {

    
    public var is_center:Bool?
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let arrayAttrs = super.layoutAttributesForElements(in: rect)
//        let centerX = (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)! * 0.5
//        for attr:UICollectionViewLayoutAttributes in arrayAttrs! {
//            let distance:CGFloat = abs(attr.center.x - centerX)
//            let factor:CGFloat = 0.001
//            let scale:CGFloat = 1 / (1 + distance * factor)
//            attr.transform = CGAffineTransform.init(scaleX: scale, y: scale)
//        }
//        return arrayAttrs
//    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if is_center! {
            let centerX = proposedContentOffset.x + (self.collectionView?.bounds.size.width)! * 0.5
            let visibleX = proposedContentOffset.x
            let visibleY = proposedContentOffset.y
            let visibleW = self.collectionView?.bounds.size.width
            let visibleH = self.collectionView?.bounds.size.height
            let visibleRect = CGRect(x: visibleX, y: visibleY, width: visibleW!, height: visibleH!)
            
            let attrs = super.layoutAttributesForElements(in: visibleRect)
            var min_idx = 0
            var min_attr:UICollectionViewLayoutAttributes = attrs![min_idx]
            
            for i:Int in 0..<(attrs?.count)! {
                let distance1 = abs(min_attr.center.x - centerX)
                let currentAttr:UICollectionViewLayoutAttributes = attrs![i]
                let distance2 = abs(currentAttr.center.x - centerX)
                if distance2 < distance1 {
                    min_idx = i
                    min_attr = currentAttr
                }
            }
            let offsetX = min_attr.center.x - centerX
            return CGPoint(x: proposedContentOffset.x + offsetX, y: proposedContentOffset.y)
        }else {
            return proposedContentOffset
        }
    }
    
    
}
