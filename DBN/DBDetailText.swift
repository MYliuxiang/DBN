//
//  DBDetailText.swift
//  DBN
//
//  Created by 刘翔 on 16/10/19.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class DBDetailText: YMBaseViewController ,UIWebViewDelegate{

    var titlesArray:[String] = []
    var contentArray:[String] = []
    var ProductID:String = ""

    var index:Int = 0
    
    var webView:UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = titlesArray[index]
        text = title
        titlesArray.removeAtIndex(index)
        titlesArray.insert(title, atIndex: 0)
        
        let content = contentArray[index]
        contentArray.removeAtIndex(index)
        contentArray.insert(content, atIndex: 0)
        
        
        let rect:CGRect = CGRectMake(0, 64, kScreenWidth, kScreenHeight  - 64 )
        webView = UIWebView(frame: rect)
        webView.delegate = self
        self.view.addSubview(webView)
        
        
        let urlstring = NSString(format: "http://www.anluyun.com/Mobile/ProductDetail?index=%d&ProductID=%@&NoTitle=&timestamp=1479796009642",index,ProductID)
        
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: urlstring as String)!))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
        
        
        view.backgroundColor = UIColor.whiteColor()
//        swap(&titlesArray[0], &titlesArray[index])
//        swap(&contentArray[0], &contentArray[index])
//       
//        tableView.registerNib(UINib(nibName: "DetailTextCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cellid1")
//        tableView.backgroundColor = UIColor.whiteColor()
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0)
//        tableView.reloadData()
//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webViewDidFinishLoad(webView: UIWebView){
        
        SVProgressHUD.dismiss()
        
        
        
    }
    
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.showErrorWithStatus("网络出错")
        
    }

    
    
    //tableView Delegate
    
    //mark tableView Delegate
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return self.titlesArray.count
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("cellid1") as! DetailTextCell
//
//        cell.contentLabel.text = self.contentArray[indexPath.row]
//        let attributedString = NSMutableAttributedString.init(string: cell.contentLabel.text!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 5
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, cell.contentLabel.text!.characters.count))
//        
//        cell.contentLabel.attributedText = attributedString
//        
//        cell.titleLabel.text = String(format:"%d  %@",indexPath.row + 1,self.titlesArray[indexPath.row] )
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//        return 0.1
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return 0.1
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return DetailTextCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//    }

    
    
   

}
