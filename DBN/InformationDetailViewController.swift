//
//  InformationDetailViewController.swift
//  DBN
//
//  Created by administrator on 2016/10/19.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class InformationDetailViewController: YMBaseViewController,UIWebViewDelegate {
    
    var webView:UIWebView!
    
    //属性监视器
    var url:String = String() {
        willSet(newUrl) {
            
        }
        didSet {
            
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text = "资讯详情"
        //加载网页
        let rect:CGRect = CGRectMake(0, 64, kScreenWidth, kScreenHeight  - 64 )
        webView = UIWebView(frame: rect)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: (self.url as? String)!)!))
        self.view.addSubview(webView)
    }

    
}
