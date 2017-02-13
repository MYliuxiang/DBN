//
//  AboutusVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class AboutusVC: YMBaseViewController ,UIWebViewDelegate{

//    @IBOutlet weak var label2: UILabel!
//    @IBOutlet weak var label1: UILabel!
    
    
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

        text = "关于我们"
        //加载网页
        let rect:CGRect = CGRectMake(0, 64, kScreenWidth, kScreenHeight  - 64 )
        webView = UIWebView(frame: rect)
        webView.delegate = self
        self.view.addSubview(webView)
        
        
        loadUrl()
        
        
        
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
                    self!.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.anluyun.com/Mobile/About?Key=AboutUs")!))
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
