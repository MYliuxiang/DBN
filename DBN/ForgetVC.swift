//
//  ForgetVC.swift
//  DBN
//
//  Created by 刘翔 on 16/9/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class ForgetVC: YMBaseViewController {

    @IBOutlet weak var phoneField: UITextField!
    
    var timer:NSTimer!
    var time = 60

    @IBOutlet weak var aginPassFeild: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var codeField: UITextField!
    
    @IBAction func nextAC(sender: AnyObject) {
        
        if phoneField.text?.characters.count == 0 {
            SVProgressHUD.showErrorWithStatus("请输入手机号！")
            return
        }
        
        if NSString.isTelNumber(phoneField.text!) {
            
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入正确手机号码！")
            return
        }
        if codeField.text?.characters.count == 0 {
            
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入验证码！")
            return
        }
        
        if passField.text?.characters.count == 0 {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入密码！")
            return
        }
        
        if aginPassFeild.text?.characters.count == 0 {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请再次输入密码！")
            return
        }
        
        if passField.text != aginPassFeild.text {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("两次密码不一致，请重新输入！")
            return
        }
        
        var dic:[String:AnyObject]
        if isregister == true {
            
            dic = ["Type":"UserRegister","Mobile":phoneField.text!,"Password":aginPassFeild.text!,"Code":codeField.text!]
            
        }else{
        
            dic = ["Type":"ResetPass","Mobile":phoneField.text!,"Password":aginPassFeild.text!,"Code":codeField.text!]
            
        }
        
        LXDataTool.getData("url",dic,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                
                if (result!["State"] as! String == "true") {
                    //成功
                    self!.sendBtn.enabled = false
                    // 启用计时器，控制每秒执行一次tickDown方法
                   self?.navigationController?.popViewControllerAnimated(true)
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
                
            }
            
        }
        
    }
    
    
    @IBAction func sendAC(sender: AnyObject) {
        
        if NSString.isTelNumber(phoneField.text!) {
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入正确手机号码！")
            return
        }
        
        
          let par = ["Type":"RegistCode","Mobile":phoneField.text! as String]
        
        LXDataTool.getData("url",par,isHUD: true){ [weak self](result) in
            
            if result != nil {
            
                
                if (result!["State"] as! String == "True") {
                //成功
           
                    self!.sendBtn.enabled = false
                    // 启用计时器，控制每秒执行一次tickDown方法
                    self!.timer = NSTimer.scheduledTimerWithTimeInterval(1,
                                                                         target:self!,selector:#selector(ForgetVC.tickDown),
                                                                         userInfo:nil,repeats:true)
                    NSRunLoop.currentRunLoop().addTimer(self!.timer, forMode: NSRunLoopCommonModes)
                    
                }else{
                //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
 
                
                }
            
            }
            
        }

    }
    
    func tickDown()
    {
        if time == 0 {
            
            timer.invalidate()
            sendBtn.enabled = true


        }else{
        time -= 1
        sendBtn.setTitle(String(format: "%d秒",time), forState: .Normal)
        }
        
    }
    
    
    var isregister = Bool!()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if isregister == true {
            
            text = "注册"
            
        }else{
        
            text = "忘记密码"
        }
        
        let rect = CGRectMake(0, 0, 10, 0)
        
        phoneField.leftView = UIView(frame:rect)
        phoneField.leftViewMode = UITextFieldViewMode.Always
        phoneField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        phoneField.layer.borderWidth = 1
        
        codeField.leftViewMode = UITextFieldViewMode.Always
        codeField.leftView = UIView(frame:rect)
        codeField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        codeField.layer.borderWidth = 1
        
        passField.leftView = UIView(frame:rect)
        passField.leftViewMode = UITextFieldViewMode.Always
        passField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        passField.layer.borderWidth = 1
        
        aginPassFeild.leftViewMode = UITextFieldViewMode.Always
        aginPassFeild.leftView = UIView(frame:rect)
        aginPassFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        aginPassFeild.layer.borderWidth = 1

        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
