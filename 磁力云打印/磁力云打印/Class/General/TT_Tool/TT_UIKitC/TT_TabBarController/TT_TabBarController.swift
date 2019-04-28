//
//  PZ_TabBarController.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/5.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit

class TT_TabBarController: UITabBarController, TT_TabBarDelegate{
   
    func didselectIndex(tabBar: TT_TabBar, selectIndex: NSInteger) {
        self.selectedIndex = selectIndex
    }
    
    var TabBar: TT_TabBar?
    
    init(controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = controllers
        
        self.TabBar = TT_TabBar.init(Frame: self.tabBar.frame, norImageArr: TT_TabBarConfigure.default.norImageArr, selectImageArr: TT_TabBarConfigure.default.selectImageArr, titleArr: TT_TabBarConfigure.default.titleArr)
        self.TabBar?.TabBarDelegate = self
        self.TabBar?.selectedIndex = 0
        TT_TabBarConfigure.default.tabBarController = self
        self.setValue(self.TabBar, forKey: "tabBar")
        self.addObserver(self, forKeyPath: "selectedIndex", options:[.old,.new], context: nil)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let selectedIndex : NSInteger = change?[NSKeyValueChangeKey.newKey] as! NSInteger
        self.TabBar?.selectedIndex = selectedIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}
