//
//  LoginVC.swift
//  DBN
//
//  Created by Viatom on 16/9/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class LoginVC: YMBaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var passwordHeaderView: UIView!
    
    @IBOutlet var userNameHeader: UIView!
    
    
    @IBOutlet weak var userNaemFeild: UITextField!
    
    @IBOutlet weak var passWordFeild: UITextField!
    
    @IBAction func forgetPassWord(sender: AnyObject) {
        
        print("注册")
        let vc = ForgetVC()
        vc.isregister = false
        navigationController?.pushViewController(vc, animated: true)
        

    }
    
    @IBAction func loginAC(sender: AnyObject) {
        
        if userNaemFeild.text?.characters.count == 0 {
            
            let alert = UIAlertView(title: nil, message: "请输入账号!", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
            
        }
        
        if NSString.isTelNumber(userNaemFeild.text!) {
            
            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showErrorWithStatus("请输入正确手机号码！")
            return
        }
        
        if passWordFeild.text?.characters.count == 0 {
            let alert = UIAlertView(title: nil, message: "请输入密码!", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            
            return
        }
        
        let token = NSUserDefaults.standardUserDefaults().objectForKey(TOKEN) 
        
        let params:[String : AnyObject] = ["Type":"Login","Mobile":userNaemFeild.text!,"Password":passWordFeild.text!,"Token":token!,"DeviceType":"1"]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
        if result != nil {
                
            if (result!["State"] as! String == "True") {
                print(result!["HeadImage"])
                //成功
                
                
                
                let dic = result!["Client"] as! NSDictionary
                
                
                
                
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setBool(true, forKey: Login)
                let imageUrl = dic["HeadImage"]  as? String
                if (imageUrl != nil){
                
                    userDefaults.setObject(dic["HeadImage"] , forKey: HeadImage)

                }
                
                let name = dic["Name_"]  as? String
                
                if (name != nil){
                
                    userDefaults.setObject(dic["Name_"] , forKey: Name)
                
                }
                
                let sexstr = dic["Sex"]  as? String
                if (sexstr != nil){
                    
                    userDefaults.setObject(dic["Sex"] , forKey: Sex)
                    
                }
                
                let DeviceIDstr = dic["DeviceID"]  as? String
                if (DeviceIDstr != nil){
                    
                    userDefaults.setObject(dic["DeviceID"] , forKey: DeviceID)
                    
                }
                
                let IDstr = dic["ID"]  as? String
                if (IDstr != nil){
                    
                    userDefaults.setObject(dic["ID"] , forKey: UserID)
                    
                }
                
                let Mobileid = dic["Mobile"]  as? String
                if (Mobileid != nil){
                    
                    userDefaults.setObject(dic["Mobile"] , forKey: Mobile)
                    
                }
                
                let favoritesCount = dic["FavoritesCount"]  as? NSNumber
                if (favoritesCount != nil){
                    
                    userDefaults.setObject(favoritesCount?.stringValue , forKey: FavoritesCount)
                    
                }
                
                
                let viewCount = dic["ViewCount"]  as? NSNumber
                if (viewCount != nil){
                    
                    userDefaults.setObject(viewCount?.stringValue , forKey: ViewCount)
                    
                }

                userDefaults.synchronize()
                self?.navigationController?.dismissViewControllerAnimated(true, completion: nil)
              
                        
            }else{
                //失败
                SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                
            }
        }
        
        }
        
    }
    override func back() {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text = "登陆"
        // Do any additional setup after loading the view.
        
        isfanhui = true
        
        addrighttitleString("注册")
        userNaemFeild.leftView = userNameHeader;
        userNaemFeild.leftViewMode = UITextFieldViewMode.Always
        
        passWordFeild.leftViewMode = UITextFieldViewMode.Always
        passWordFeild.leftView = passwordHeaderView
        
        
//        passWordFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        
        passWordFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        passWordFeild.layer.borderWidth = 1
        
        userNaemFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        userNaemFeild.layer.borderWidth = 1
        
        let tap = UITapGestureRecognizer(target:self, action:#selector(tapAC))
        view.addGestureRecognizer(tap)
        

    }
    
    func tapAC() {
    
        view.endEditing(true);
    }
    
    override func rightAC() {
        
        print("注册")
        let vc = ForgetVC()
        vc.isregister = true
        navigationController?.pushViewController(vc, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}







