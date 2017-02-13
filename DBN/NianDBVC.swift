//
//  NianDBVC.swift
//  DBN
//
//  Created by Viatom on 16/10/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class NianDBVC: YMBaseViewController {

    @IBOutlet weak var channelScrollView: UIScrollView!
    var channels:[NSString] = []
    
    var cacheCategoryViews = [UIView]()
    var labelArray: [ChannelLabel] = []
    var currentChannelsLabel: ChannelLabel!
    var maxchannelsCount: Int = 20
    var channelCount: Int!
    let labelMargin: CGFloat = 25
    
    @IBOutlet weak var newsContainerView: NewsContainerView!
    var newsListVcArray: [DBSubVC] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        text = "年度地标"
        addImageString("标题栏-查找")
       
        loadNianTitles()
        
        
    }
    
    func loadNianTitles(){
    
        let params:[String : AnyObject] = ["Type":"QueryYears","Mobile":""]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                    self?.channels = result!["Years"] as! [String]
                    self!.setupChannelScrollView()
                    self!.setupNewsContainerView()
                    self!.showFirstNewsList()
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
        
    
    }
    
    
    
    func showFirstNewsList() {
        
        let vc = self.newsListVcArray.first!
        self.newsContainerView.showViewInScrollView(vc.view, showViewIndex: 0)
        
        let label = self.labelArray.first!
        currentChannelsLabel = label
        label.scale = 1
    }

    /**
     channelScrollView的一些初始化操作，
     用来创建默认的新闻频道
     */
    func setupChannelScrollView() {
        channelCount = channels.count > maxchannelsCount ? maxchannelsCount : channelCount
        let labelX: ([UILabel]) -> CGFloat = {
            (labels: [UILabel]) -> CGFloat in
            
            let lastObj = labels.last
            guard let label = lastObj else {
                return self.labelMargin
            }
            return CGRectGetMaxX(label.frame) + self.labelMargin
        }
        
        for i in 0..<channels.count {
            let label = ChannelLabel()
            label.text = self.channels[i] as String
            label.textColor = UIColor.blackColor()
            label.font = UIFont.systemFontOfSize(14)
            label.sizeToFit()
            label.frame.origin.x = labelX(self.labelArray)
            label.frame.origin.y = (self.channelScrollView.bounds.height -  label.bounds.height) * 0.5
            //添加点击事件
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NianDBVC.channelLabelClick(_:))))
            label.userInteractionEnabled = true
            label.tag = i
            self.labelArray.append(label)
            self.channelScrollView.addSubview(label)
        }
        self.channelScrollView.contentSize = CGSizeMake(labelX(self.labelArray), 0)
        self.channelScrollView.bounces = false

    }

    func setupNewsContainerView() {
        
        for i in 0..<channels.count {
            let vc = DBSubVC()
//            vc.channel = self.channels[i].channelName
//            vc.channelUrl = self.channels[i].channelUrl
            vc.year = channels[i] as String
            self.newsListVcArray.append(vc)
            //成为自控制器，方便以后调用
            self.addChildViewController(vc)
        }
        
        self.newsContainerView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * CGFloat(self.newsListVcArray.count), 0)
        self.newsContainerView.pagingEnabled = true
        self.newsContainerView.bounces = false
        self.newsContainerView.delegate = self
    }

    
    
    func channelLabelClick(recognizer: UITapGestureRecognizer) {
        
        let label = recognizer.view as! ChannelLabel
        let index = label.tag
        
      

        
        let offsetX = CGFloat(index) * self.newsContainerView.bounds.width
        let offset = CGPointMake(offsetX, 0)
        self.newsContainerView.setContentOffset(offset, animated: true)
//        代码滚动到显示了那一"页"
        self.scrollViewDidEndScrollingAnimation(self.newsContainerView)
        
//        label.scale = 1
//        self.currentChannelsLabel.scale = 0
    }

    
   
    
    override func rightAC() -> () {
        
        navigationController?.pushViewController(ScanVC(), animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


// MARK: - UIScrollView的代理方法(newsContainerView)

extension NianDBVC: UIScrollViewDelegate{
    
    /**
     每次滑动newsContainerView都会调用，用来制造频道label的动画效果
     */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        for i in 0..<labelArray.count {
            
            let label = self.labelArray[i]
            
            if i == Int(currentIndex) {
                
                label.scale = 1
            }else{
            
                label.scale = 0

            }
            
       }
        
     
        
    }
    
    /**
     这个是在newsContainerView减速停止的时候开始执行，
     用来切换需要显示的新闻列表和让频道标签处于合适的位置
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    /**
     这个是当用户用代码导致滚动时候调用列如setContentOffset，
     用来切换需要显示的新闻列表和让频道标签处于合适的位置
     */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 让频道标签处于合适的位置
        let currentLabel = self.labelArray[index]
        self.currentChannelsLabel = currentLabel
        var offsetX = currentLabel.center.x - self.channelScrollView.bounds.width * 0.5
        let maxOffset = self.channelScrollView.contentSize.width - self.channelScrollView.bounds.width
        if offsetX > 0{
            offsetX = offsetX > maxOffset ? maxOffset : offsetX
        }else {
            offsetX = 0
        }
        let offset = CGPointMake(offsetX, 0)
        self.channelScrollView.setContentOffset(offset, animated: true)
        
        // 切换需要显示的控制器
        let vc = self.newsListVcArray[index]
        self.newsContainerView.showViewInScrollView(vc.view, showViewIndex: index)
        
    }
    
}


















