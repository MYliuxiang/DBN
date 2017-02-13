//
//  YMTableViewController.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/7/29.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit


class YMTabBarController: UITabBarController {

    
    static let sharedInstance = YMTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        addChildViewControllers()
        tabBar.tintColor = LXColor(88, g: 158, b: 59, a: 1)
        
    }
    
    override class func initialize() {
//        let tabBar = UITabBar.appearance()
        
        
    }
    
    class TheOneAndOnlyKraken {
        class var sharedKraken: YMTabBarController {
            return self.sharedKraken
        }
    }

    
    
    /**
     # 添加子控制器
     */
    private func addChildViewControllers() {
//        addChildViewController(YMHomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
//        addChildViewController(YMVideoViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
//        addChildViewController(YMNewCareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
//        addChildViewController(YMMineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let nav = YMNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
}
