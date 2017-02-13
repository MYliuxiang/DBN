//
//  FixPassVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class FixPassVC: YMBaseViewController {

    @IBAction func doneAC(sender: AnyObject) {
        
        
        if (currentPassField.text == nil) {
            
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入当前密码！")
            return
        }
        
        if (newpassField.text == nil) {
            
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入新密码！")
            return
        }
        
        if (aginPassField.text == nil) {
            
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请确认新密码")
            return
        }
        
        if (aginPassField.text != newpassField.text) {
            
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("两次输入的密码不一致！")
            return
        }
        
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as! NSString
        let dic = ["Type":"ChangePass","Mobile":mobile,"OldPassword":currentPassField.text!,"Password":aginPassField.text!]
        
        LXDataTool.getData("url",dic,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                    
                    self!.navigationController?.popViewControllerAnimated(true)
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }

        
        
        
        
        
        
    }
    @IBOutlet weak var aginPassField: UITextField!
    @IBOutlet weak var newpassField: UITextField!
    @IBOutlet weak var currentPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let rect = CGRectMake(0, 0, 10, 0)
        
        aginPassField.leftView = UIView(frame:rect)
        aginPassField.leftViewMode = UITextFieldViewMode.Always
        aginPassField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        aginPassField.layer.borderWidth = 1

        
        newpassField.leftViewMode = UITextFieldViewMode.Always
        newpassField.leftView = UIView(frame:rect)
        newpassField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        newpassField.layer.borderWidth = 1
        
        currentPassField.leftView = UIView(frame:rect)
        currentPassField.leftViewMode = UITextFieldViewMode.Always
        currentPassField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        currentPassField.layer.borderWidth = 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
