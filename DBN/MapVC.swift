//
//  MapVC.swift
//  DBN
//
//  Created by 刘翔 on 16/10/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class MapVC: YMBaseViewController ,UIWebViewDelegate{
    

    
    var webView:UIWebView!
    var textStr:String = ""
    //属性监视器
    var url:String = String() {
        willSet(newUrl) {
            
        }
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.text = textStr
        //加载网页
        let rect:CGRect = CGRectMake(0, 64, kScreenWidth, kScreenHeight  - 64 )
        webView = UIWebView(frame: rect)
        webView.delegate = self
        self.view.addSubview(webView)
        
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
        

//        loadUrl()

    }
    
    func loadUrl(){
    
        let params:[String : AnyObject] = ["Type":"Configs"]
        
        LXDataTool.getData("url",params,isHUD: false){ [weak self](result) in
            
            if result != nil {
                
                print(result)
                if (result!["State"] as! String == "True") {
                    
                let dic = result!["Configs"] as! NSDictionary
                    let urlStr = dic["MobileMapUrl"] as! String
                  
                    print(urlStr)
                    self!.webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
                    SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
                    

                    
                    }
                
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
    
    
    
    
    func webViewDidFinishLoad(webView: UIWebView){
    
        SVProgressHUD.dismiss()

        
    
    }
    
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.showErrorWithStatus("网络出错")
        
    }


}
