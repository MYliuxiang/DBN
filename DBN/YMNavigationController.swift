//
//  YMNavigationController.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/7/29.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit

class YMNavigationController: UINavigationController {

    override class func initialize() {
        super.initialize()
//        let navBar = UINavigationBar.appearance()
//        navBar.barTintColor = UIColor.redColor()
//        navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置系统返回按钮的颜色
//        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        
        //取消导航栏的透明效果
        self.navigationBar.translucent = false;
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .Plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBack() {
        popViewControllerAnimated(true)
    }

      
}
