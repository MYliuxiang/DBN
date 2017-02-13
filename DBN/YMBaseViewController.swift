//
//  YMBaseViewController.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/7/29.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit

class YMBaseViewController: UIViewController {


    var nav:UIView?
    var titleLabel: UILabel?
    var backButton: UIButton?
    var isfanhui:Bool?{
       
        didSet{
        
            if (isfanhui == true) {
                backButton?.hidden = false
                
            }else{
                backButton?.hidden = true
            
            }
            
        }
    }
    var text:NSString?{
    
        didSet{
        
            titleLabel?.text = text as? String
            titleLabel?.sizeToFit()
            titleLabel?.center = CGPointMake(kScreenWidth / 2.0, 42)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        self.navigationController?.navigationBar.hidden = true
        automaticallyAdjustsScrollViewInsets = false
        creatNav()
        view.backgroundColor = UIColor.lxcolorWithHexString("#f2f2f2")
        
    }
    
    func creatNav(){
        
        nav = UIView()
        nav?.backgroundColor = LXColor(88, g: 158, b: 59, a: 1)
        nav?.frame = CGRectMake(0, 0, kScreenWidth, 64)
//        view.addSubview(nav!)
        view.insertSubview(nav!, atIndex: 0)
        
        titleLabel = UILabel()
        titleLabel?.backgroundColor = UIColor.clearColor()
        titleLabel?.textColor = UIColor.whiteColor()
        titleLabel?.textAlignment = .Center
        nav?.addSubview(titleLabel!)
        
        
        
        backButton = UIButton(type:.Custom)
        backButton?.frame = CGRectMake(15, (42 - 25) / 2.0 + 20, 24, 25)
        backButton?.addTarget(self, action:#selector(back) , forControlEvents: .TouchUpInside)
        backButton?.setImage(UIImage(named:"标题栏-返回箭头" ), forState: .Normal)
        nav?.addSubview(backButton!)
        
        if self.navigationController?.viewControllers.count > 1 {
            
            backButton?.hidden = false
            
        }else{
        
            backButton?.hidden = true

        }
        
        
    }
    
    
    func addrighttitleString(string:String) -> () {
        
        
        let rect = CGRectMake(kScreenWidth - 70, 0, 70, 64)
        let rightview = UIView(frame:rect)
        rightview.backgroundColor = UIColor.clearColor()
        rightview.userInteractionEnabled = true
        nav?.addSubview(rightview)
        
        let tap = UITapGestureRecognizer(target:self, action:#selector(rightAC))
        rightview.addGestureRecognizer(tap)
        
        let rightbutton = UIButton(type:.Custom)
        rightbutton.frame = CGRectMake(kScreenWidth - 70, 20 + (nav!.height - 20 - 50 / 2.0) / 2.0 , 70 , 50 / 2.0);
        rightbutton.setTitle(string, forState: .Normal)
        rightbutton.titleLabel?.font = UIFont.systemFontOfSize(16)
        rightbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightbutton.addTarget(self, action: #selector(rightAC), forControlEvents: .TouchUpInside)
        nav!.addSubview(rightbutton)
        
    }
    
    func addImageString(string:String) -> () {
        
        
        let rect = CGRectMake(kScreenWidth - 70, 0, 70, 64)
        let rightview = UIView(frame:rect)
        rightview.backgroundColor = UIColor.clearColor()
        rightview.userInteractionEnabled = true
        nav?.addSubview(rightview)
        
        let tap = UITapGestureRecognizer(target:self, action:#selector(rightAC))
        rightview.addGestureRecognizer(tap)
        
        let rightbutton = UIButton(type:.Custom)
        rightbutton.frame = CGRectMake(kScreenWidth - 70, 20 + (nav!.height - 20 - 50 / 2.0) / 2.0 , 70 , 50 / 2.0);
        rightbutton.setImage(UIImage(named:string), forState: .Normal)
        rightbutton.titleLabel?.font = UIFont.systemFontOfSize(16)
        rightbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightbutton.addTarget(self, action: #selector(rightAC), forControlEvents: .TouchUpInside)
        nav!.addSubview(rightbutton)
        
    }


    func rightAC() -> () {
        
        
        
    }
    
    func back() -> () {
        
        navigationController?.popViewControllerAnimated(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
