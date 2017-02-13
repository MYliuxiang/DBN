//
//  FixNickNameVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class FixNickNameVC: YMBaseViewController {

    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "修改昵称"
        addrighttitleString("确定")
        // Do any additional setup after loading the view.
        
        let label = UILabel()
        label.frame = CGRectMake(0, 0, 50, 40)
        label.text = "昵称:"
        label.font = UIFont.systemFontOfSize(15)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        nameField.leftViewMode = UITextFieldViewMode.Always
        nameField.leftView = label
        
        
        //        passWordFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        
        nameField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        nameField.layer.borderWidth = 1

    }

    
   override func rightAC() -> () {
    
    if (nameField.text == nil) {
        
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.showErrorWithStatus("请输入昵称！")
        return
    }
    
    let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as! NSString
    let dic = ["Type":"EditClient","Mobile":mobile,"Name_":nameField.text!,"Sex":"","HeadImage":""]
    
    LXDataTool.getData("url",dic,isHUD: true){ [weak self](result) in
        
        if result != nil {
            
            print(result)
            if (result!["State"] as! String == "True") {
                
                NSUserDefaults.standardUserDefaults().setObject(self!.nameField.text, forKey: Name)
                 NSUserDefaults.standardUserDefaults().synchronize()
                
                self!.navigationController?.popViewControllerAnimated(true)
                
            }else{
                //失败
                SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                
            }
        }
        
    }
    
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
