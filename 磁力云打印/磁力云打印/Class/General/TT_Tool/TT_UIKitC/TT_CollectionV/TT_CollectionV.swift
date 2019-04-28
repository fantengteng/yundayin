//
//  TT_CollectionV.swift
//  PZ_swift
//
//  Created by linlin dang on 2018/7/15.
//  Copyright © 2018年 FTT. All rights reserved.
//

import UIKit


protocol TT_CollectionVDelegate {
    func selectcycleScollviewIndex(index:NSInteger)
}
class TT_CollectionV: UIView {
    
    
    //=======================================================
    // MARK: 对外提供的属性
    //=======================================================
    
    /// 是否无限循环 默认true
    public var infiniteLoop:Bool?
    /// 是否自动滑动 默认true
    public var autoScroll:Bool? {
        didSet {
            if autoScroll! {
                setupTimer()
            }
        }
    }
    /// 是否中间显示
    public var is_center:Bool? {
        didSet {
            flowLayout.is_center = is_center!
        }
    }
    /// 组头大小
    public var CellHeadSize:CGSize? {
        didSet {
            flowLayout.headerReferenceSize = CellHeadSize! // 页眉宽高
        }
    }
    /// 组尾大小
    public var CellFootSize:CGSize? {
        didSet {
            flowLayout.footerReferenceSize = CellFootSize! // 页眉宽高
        }
    }
    /// 是否缩放 默认false
    public var isZoom:Bool?
    /// 自动滚动间隔时间 默认2s
    public var autoScrollTimeInterval:CGFloat?
    /// cell高度
    public var itemSize:CGSize? {
        didSet {
            flowLayout.itemSize = itemSize!
        }
    }
    /// cell间距
    public var itemSpace:CGFloat? {
        didSet {
            flowLayout.minimumLineSpacing = itemSpace!
        }
    }
    /// 图片圆角
    public var imagCornerRadius:CGFloat?
    /// 是否有分页控制器
    public var Is_pageControl:Bool?
    /// 分页控制器
    public var pageControl:UIPageControl?
    /// 占位图， 用于网络加载到图片时
    public var placeholderImage:UIImage?
    /// 轮播图片的类型
    public var bannerImageViewMode:UIViewContentMode?
    
    /// 自定义类名 需要继承CycleScrollViewCell
    public var cellClass:AnyClass? {
        didSet {
            collectonView.register(cellClass!.self, forCellWithReuseIdentifier: cellID)
        }
    }
    
    public var XIBClass: String? {
        didSet {
            collectonView.register(UINib(nibName: XIBClass!, bundle: nil), forCellWithReuseIdentifier: cellID)
        }
    }
    /// 代理
    public var CollecDelegate:TT_CollectionVDelegate?
    
    /// 数据源
    public var imageArr:[AnyObject]? {
        didSet {
            setImageData(Array: imageArr!)
        }
    }
    
    //=======================================================
    // MARK: 私有属性
    //=======================================================
    
    /// 背景图片
    fileprivate var backgroundImageView:UIImageView?
 
    /// item总数
    fileprivate var totalItems:Int?
    /// 定时器
    fileprivate var timer:Timer?
    /// 当前页
    fileprivate var currentpage:Int?
    /// 标示
    fileprivate let cellID = "cellID"
    ///
    fileprivate var oldPoint:CGFloat?
    
    fileprivate var dragDirection: NSInteger?
    
    fileprivate lazy var flowLayout: TT_FlowLayout = {
        let flow = TT_FlowLayout.init()
        flow.scrollDirection =  .horizontal
        flow.minimumLineSpacing = 0
        return flow
    }()
    
    fileprivate lazy var collectonView: UICollectionView = {
        let cv = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.scrollsToTop = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultConfiguration()
        setupSubViewS()
    }

    
    init(frame:CGRect ,infiniteLoop:Bool ,imageGroup:[AnyObject] ,cellName:AnyClass) {
        super.init(frame: frame)
        self.cellClass    = cellName
        self.infiniteLoop = infiniteLoop
        self.imageArr = imageGroup;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectonView.frame = self.bounds
        self.pageControl?.frame  = CGRect(x: 0, y: self.bounds.size.height - 30, width: self.bounds.size.width, height: 30)
        self.flowLayout.itemSize = itemSize!
        self.flowLayout.minimumLineSpacing = itemSpace!
    
        if collectonView.contentOffset.x == 0 && totalItems! > 0 {
            var targeIndex = 0
            if infiniteLoop! {
                targeIndex = totalItems! / 2
            }
            collectonView.scrollToItem(at: IndexPath.init(row: targeIndex, section: 0), at: .centeredHorizontally, animated: false)
            oldPoint = collectonView.contentOffset.x
            collectonView.isUserInteractionEnabled = true
        }
    }
}


extension TT_CollectionV:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItems!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TT_CycleScrollViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TT_CycleScrollViewCell
        let itemIndex = Int(indexPath.item % (self.imageArr?.count)!)
        let imagePath = imageArr![itemIndex]
        cell.imaageView.contentMode = self.bannerImageViewMode!
        cell.imgCornerRadius = self.imagCornerRadius!
        cell.config(data: imagePath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CollecDelegate?.selectcycleScollviewIndex(index: currentIndex() % (imageArr?.count)!)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //collectonView.isUserInteractionEnabled = false
        if self.imageArr?.count == 0  {
            return
        }
        if Is_pageControl! {
            self.pageControl?.currentPage = currentIndex() % (self.imageArr?.count)!
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        oldPoint = scrollView.contentOffset.x
        if autoScroll! {
            invalidateTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScroll! {
            setupTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(collectonView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //collectonView.isUserInteractionEnabled = true
        if imageArr?.count == 0 {
            return
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if is_center! {
            let currentPoint = scrollView.contentOffset.x
            let moveWidth = currentPoint - oldPoint!
            let shouldPage = moveWidth / ((itemSize?.width)! / 2)
            if velocity.x > 0 || shouldPage > 0 {
                dragDirection = 1
            }else if velocity.x < 0 || shouldPage < 0 {
                dragDirection = -1
            }else {
                dragDirection = 0
            }
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if is_center! {
            var currentIndex = Int((oldPoint! + ((itemSize?.width)! + itemSpace!) / 2) / (itemSpace! + (itemSize?.width)!)) + dragDirection!
             if !(infiniteLoop!) {
                if currentIndex >= totalItems! {
                    currentIndex = totalItems! - 1
                }else if currentIndex < 0 {
                    currentIndex = 0
                }
            }
            collectonView.scrollToItem(at: IndexPath.init(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}





// MARK: - 私有
extension TT_CollectionV {
    

    
    /// 设置默认值
    func setupDefaultConfiguration() {
        autoScrollTimeInterval = 4
        CellHeadSize = CGSize(width: 0, height: 0)
        CellFootSize = CGSize(width: 0, height: 0)
        infiniteLoop = true
        autoScroll = true
        isZoom = false
        itemSize = self.bounds.size
        itemSpace = 0
        imagCornerRadius = 8
        is_center = true
        pageControl?.currentPage = 0
        bannerImageViewMode = .scaleToFill
        Is_pageControl = false
    }
    
    func setupSubViewS (){
        addSubview(self.collectonView)
        if Is_pageControl! {
            addSubview(self.pageControl!)
        }
    }
    
    func setImageData(Array: [AnyObject]) {
        pageControl?.numberOfPages = Array.count
        totalItems = infiniteLoop! ? Array.count * 500: Array.count
        if Array.count > 1 {
            collectonView.isScrollEnabled = true
            configAutoScroll(YorN: autoScroll!)
        }else {
            collectonView.isScrollEnabled = false
            invalidateTimer()
        }
        collectonView.reloadData()
    }
    
    func configAutoScroll(YorN:Bool) {
        invalidateTimer()
        if YorN {
            setupTimer()
        }
    }
    
    /// 设置定时器
    func setupTimer() {
        invalidateTimer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.autoScrollTimeInterval!), target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    /// 销毁定时器
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 定时器触发事件
    @objc func automaticScroll() {
        if totalItems == 0 {
            return
        }
        let curr = currentIndex()
        let targ = curr + 1
        scrollToIndex(index: targ)
    }
    
    /// 获取当前的位置
    func currentIndex() -> NSInteger {
        if collectonView.frame.size.width == 0 || collectonView.frame.size.height == 0 {
            return 0
        }
        var index:NSInteger = 0
        if flowLayout.scrollDirection == .horizontal {
            index = NSInteger((collectonView.contentOffset.x + ((itemSize?.width)! + itemSpace!) * 0.5) / (itemSpace! + (itemSize?.width)!))
        }else {
            index = NSInteger((collectonView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height)
        }
        return max(0, index)
    }
    
    /// 指定位置滑动到中间
    func scrollToIndex(index: NSInteger) {
        if index >= totalItems! {
            if infiniteLoop! {
                let indexs = totalItems! / 2
                collectonView.scrollToItem(at: IndexPath.init(row: indexs, section: 0), at: .centeredHorizontally, animated: false)
            }
            return
        }
        collectonView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

