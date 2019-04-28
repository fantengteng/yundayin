//
//  TT_TabBar.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/8.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

let transform: String = "transform."
let translation: String = "translation."
let scale: String = "scale"

let transY: String = transform + translation + "y"
let transX: String = transform + translation + "x"
let transZ: String = transform + translation + "z"
let transScale: String = transform + scale

protocol TT_TabBarDelegate {
    func didselectIndex(tabBar:TT_TabBar , selectIndex: NSInteger)
}

class TT_TabBar: UITabBar {
    
   
    fileprivate lazy var norImageArrM: [String] = {
        var Arr = [String]()
        return Arr
    }()
    
    fileprivate lazy var selectImageArr: [String] = {
        var Arr = [String]()
        return Arr
    }()
    
    fileprivate lazy var saveTabBarArrM: [Any] = {
        var Arr = [Any]()
        return Arr
    }()
    
    fileprivate lazy var titleImageArrM: [String] = {
        var Arr = [String]()
        return Arr
    }()

    public var TabBarDelegate: TT_TabBarDelegate?
    
    fileprivate var CenterBtn: UIButton?
    public var selectedIndex: NSInteger? {
        didSet {
            setupSelectdIndex(selectdIndex: selectedIndex!)
        }
    }
    
    convenience init(Frame: CGRect, norImageArr: [String], selectImageArr: [String], titleArr: [String]) {
        self.init()
        self.backgroundColor = UIColor.white
        setupSubViewS(norImageArr: norImageArr, selectImageArr: selectImageArr, titleArr: titleArr)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var tempArr: [Any] = [Any]()
        for tabBarButton: UIView in self.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabBarButton.removeFromSuperview()
            }
            if tabBarButton.isKind(of: TT_TabBarButton.self) || tabBarButton.isKind(of: UIButton.self){
                tempArr.append(tabBarButton)
            }
        }
        
        for i  in 0..<tempArr.count {
            let view: UIView = tempArr[i] as! UIView
            if view.isKind(of: UIButton.self) {
                self.CenterBtn = view as? UIButton
                tempArr.insert(view, at: view.tag)
                tempArr.removeLast()
                break
            }
        }
        
        let viewW: CGFloat = self.width! / CGFloat(tempArr.count)
        let viewH: CGFloat = 49
        let viewY: CGFloat = 0
        
        for i in 0..<tempArr.count {
            let viewX: CGFloat = CGFloat(i) * viewW
            let view: UIView = tempArr[i] as! UIView
            if view.isKind(of: UIButton.self) {
                view.frame = CGRect(x: viewX, y: TT_TabBarConfigure.default.tabBarCustonBtnY, width: viewW, height: viewH)
            }else {
                view.frame = CGRect(x: viewX, y: viewY, width: viewW, height: viewH)
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }else {
            if self.CenterBtn != nil {
                // 将单线触发摸点转换到按钮上生成新的点
                let onButton = self.convert(point, to: self.CenterBtn)
                // 判断新的点是否在按钮上
                if (self.CenterBtn?.point(inside: onButton, with: event))!{
                    return CenterBtn
                }else {
                    return super.hitTest(point, with: event)
                }
            }else {
                return super.hitTest(point, with: event)
            }
        }
    }
}





// MARK: - 方法
extension TT_TabBar {
    
    
    func setupSubViewS(norImageArr: [String], selectImageArr: [String], titleArr: [String]) {
        
        for i in 0..<titleArr.count {
            let taBtn: TT_TabBarButton = TT_TabBarButton()
            taBtn.tt = TT_TabBarConfigure.default.tabButtonConfig
            taBtn.BadgeValueConfigure = TT_TabBarConfigure.default.tabBarBadgeValueConfigure
            taBtn.imageView?.image = UIImage(named: norImageArr[i])
            taBtn.title?.text = titleArr[i]
            taBtn.title?.textColor = TT_TabBarConfigure.default.noTitleColor
            taBtn.tag = i
            self.addSubview(taBtn)
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
            taBtn.addGestureRecognizer(tap)
            self.saveTabBarArrM.append(taBtn)
        }
        self.titleImageArrM = titleArr
        self.norImageArrM   = norImageArr
        self.selectImageArr = selectImageArr
        topLineIsClearColor(isClearColor: TT_TabBarConfigure.default.isClearTabBarTopLine)
    }
    
    
    @objc func tapClick(tap: UITapGestureRecognizer) {
        setupSelectdIndex(selectdIndex: (tap.view?.tag)!)
        TabBarDelegate?.didselectIndex(tabBar: self, selectIndex: (tap.view?.tag)!)
    }
    
    func setupSelectdIndex(selectdIndex: NSInteger) {

        let NUM: Int = self.saveTabBarArrM.count
        for t in 0..<NUM {
            let btn:TT_TabBarButton = self.saveTabBarArrM[t] as! TT_TabBarButton
            if t == selectdIndex {
                btn.title?.textColor = TT_TabBarConfigure.default.selectTitleColor
                btn.imageView?.image = UIImage(named: self.selectImageArr[t])
                let type: TT_ConfigTabBarAnimType = TT_TabBarConfigure.default.tabBarAnimType
                if type == .RotationY {
                    btn.imageView?.layer.add(TT_Animation.TT_TabBarRotation(rotation: "y"), forKey: "transform.transkation.y")
                }else if type == .Scale {
                    let anim:CABasicAnimation = CABasicAnimation.init(keyPath: transY)
                    var point: CGPoint = (btn.imageView?.frame.origin)!
                    point.y -= 15
                    anim.toValue = NSNumber(floatLiteral: Double(point.y))
                    
                    let anim1: CABasicAnimation = CABasicAnimation.init(keyPath: transScale)
                    anim1.toValue = NSNumber.init(value: 1.3)
                    
                    let grounp: CAAnimationGroup = CAAnimationGroup.init()
                    grounp.fillMode = kCAFillModeForwards
                    grounp.isRemovedOnCompletion = false
                    grounp.animations = [anim,anim1]
                    btn.imageView?.layer.add(grounp, forKey: "groupAnimation")
                }else if type == .BoundsMin {
                    btn.imageView?.layer.add(TT_Animation.TT_TabarBoundsMinOrMax(Point: CGPoint(x: 12, y: 12)), forKey: "min")
                }else if type == .BoundsMax {
                    btn.imageView?.layer.add(TT_Animation.TT_TabarBoundsMinOrMax(Point: CGPoint(x: 46, y: 46)), forKey: "max")
                }
            }else {
                btn.title?.textColor = TT_TabBarConfigure.default.noTitleColor
                btn.imageView?.image = UIImage.init(named: self.norImageArrM[t])
                btn.imageView?.layer.removeAllAnimations()
            }
        }
    }
    
    
    func topLineIsClearColor(isClearColor: Bool) {
        var color:UIColor = .clear
        if !isClearColor {
            color = TT_TabBarConfigure.default.tabBarTopLineColor
        }
        self.backgroundImage = initWithImage(color: .white)
        self.shadowImage = initWithImage(color: color)
    }
    
    func initWithImage(color:UIColor)->UIImage{
        let rect = CGRect(x: 0,y: 0,width: 1,height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
