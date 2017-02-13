//
//  LookUpPassVC.swift
//  DBN
//
//  Created by 刘翔 on 16/9/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class LookUpPassVC: YMBaseViewController {

    @IBOutlet weak var passField: UITextField!
    var isregister = Bool?()

    @IBOutlet weak var aginPassFeild: UITextField!
    
    @IBAction func doneAC(sender: AnyObject) {
        
        let a = (navigationController?.viewControllers.count)! - 3
        
        let vc:UIViewController = (navigationController?.viewControllers[a])!
        navigationController?.popToViewController(vc, animated: true)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if isregister == true {
            
            text = "注册"
            
        }else{
            
            text = "找回密码"
        }
        
        let rect = CGRectMake(0, 0, 5, 0)
        
        passField.leftView = UIView(frame:rect)
        passField.leftViewMode = UITextFieldViewMode.Always
        
        aginPassFeild.leftViewMode = UITextFieldViewMode.Always
        aginPassFeild.leftView = UIView(frame:rect)
        
        passField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        passField.layer.borderWidth = 1
        
        aginPassFeild.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        aginPassFeild.layer.borderWidth = 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
