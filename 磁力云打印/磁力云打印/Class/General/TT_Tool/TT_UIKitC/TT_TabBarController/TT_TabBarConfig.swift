
//
//  TT_TabBarConfig.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/8.
//  Copyright © 2018年 FTT. All rights reserved.
//

import Foundation



public class TT_TabBarConfigure: NSObject {
    
    static let `default` = TT_TabBarConfigure()
    /// 默认图片
    public var norImageArr: [String] = ["shouye","wode"]
    /// 选中图片
    public var selectImageArr: [String] = ["shouye_select","wode_select"]
    /// 类
    public var ClassNameArr: [String] = ["PZ_HomeC","PZ_MyC"]
    /// 文字
    public var titleArr: [String] = ["",""]
    /// tabbar默认字体颜色
    public var noTitleColor: UIColor = .gray
    /// tabbar选中字体颜色
    public var selectTitleColor: UIColor = .orange
    /// tabbar 按钮动画类型
    public var tabBarAnimType: TT_ConfigTabBarAnimType = .RotationY
    /// 是否显示顶部细线
    public var isClearTabBarTopLine: Bool = true
    /// 细线颜色（默认亮灰色）
    public var tabBarTopLineColor: UIColor = .gray
    /// tabBar的背景颜色（默认白色）
    public var tabBarBackground: UIColor = .white
    /// 自定义按钮的Y
    public var tabBarCustonBtnY: CGFloat = -18
    
    public var tabButtonConfig = TT_TabButtonConfigure()
    
    public var tabBarBadgeValueConfigure = TT_TabBarBadgeValueConfigure()
    
    var tabBarController: TT_TabBarController?
    
}

extension TT_TabBarConfigure {
    
    private func getTabBarButtonAtIndex(Index: NSInteger) -> TT_TabBarButton {
        let subViews:[Any] = (self.tabBarController?.TabBar?.subviews)!
        for i in 0..<subViews.count {
            let tabBarButton: UIView = subViews[i] as! UIView
            if tabBarButton.isKind(of: TT_TabBarButton.self) && tabBarButton.tag == Index {
                let tabBarBtn: TT_TabBarButton = tabBarButton as! TT_TabBarButton
                return tabBarBtn
            }
        }
        return TT_TabBarButton()
    }
    
    @objc func customBtnClick(btn:UIButton) {
       
    }
}


extension TT_TabBarConfigure {
    
    public func showNumber(badgeVale: String, AtIndex: NSInteger) {
        let tabBarButton: TT_TabBarButton = getTabBarButtonAtIndex(Index: AtIndex)
        tabBarButton.badgeValue?.isHidden = false
        tabBarButton.badgeValue?.badgeL.text = badgeVale
        tabBarButton.badgeValue?.type = .Number
    }
    
    public func hideBadgeAtIndex(index: NSInteger) {
        getTabBarButtonAtIndex(Index: index).badgeValue?.isHidden = true
    }
    
    public func addCustomBtn(btn: UIButton, index:NSInteger) {
        btn.tag = index
        btn.addTarget(self, action: #selector(customBtnClick(btn:)), for: .touchUpInside)
        self.tabBarController?.TabBar?.addSubview(btn)
    }
    
}
public class TT_TabBarBadgeValueConfigure: NSObject {
    
    /// 角标字体颜色
    public var badgeTextColor: UIColor = .white
    /// 角标背景颜色
    public var badgeBackgroundColor: UIColor = .red
    /// 角标字体大小
    public var badegeFont: CGFloat = 10.0
    /// 角标圆角
    public var badgelayerRadius: CGFloat = 8.0
    /// 角标动画
    public var AnimType: TT_configBadgeAnimType = .Shake
    
}


public class TT_TabButtonConfigure: NSObject {
    /// 图片大小
    public var imageSiez:CGSize = CGSize(width: 28, height: 28)
    /// 图片的偏移量
    public var imageOffset:CGFloat = 2
    /// 按钮的布局
    public var typeLayout:TT_TabBarButtonType = .Image
    /// 字体的偏移量
    public var titleOffset:CGFloat = 2
    /// 字体的大小
    public var titleFont: CGFloat = 12
    
}
@objc public enum TT_TabBarButtonType: Int {
    ///  默认布局 图上 文下
    case Normal = 0
    ///  只有图片
    case Image
}


public enum TT_ConfigTabBarAnimType {
    case Normal
    ///  Y轴旋转
    case RotationY
    ///  缩小
    case BoundsMin
    ///  放大
    case BoundsMax
    ///  缩放动画
    case Scale
}


public enum TT_configBadgeAnimType: Int {
    ///  无动画
    case Noemal = 0
    ///  抖动动画
    case Shake
    ///  透明过度动画
    case Opacity
    ///  缩放动画
    case Scale
}
