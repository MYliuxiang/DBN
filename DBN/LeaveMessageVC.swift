//
//  LeaveMessageVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class LeaveMessageVC: YMBaseViewController,UITextViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func sendAC(sender: AnyObject) {
        
        
        if textView.text?.characters.count == 0 {
            
            let alert = UIAlertView(title: nil, message: "请输入留言内容!", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
            
        }
        
        
        if textField.text?.characters.count == 0 {
            let alert = UIAlertView(title: nil, message: "请输入联系方式!", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            
            return
        }
        
        
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        var params:[String : AnyObject]
        
        if (mobile == nil) {
            
            params = ["Type":"LeaveAMessage","Mobile":"","Name_":"","Contact":textField.text!,"DeviceType":"1","Message_":textView.text]
            
        }else{
            
            params = ["Type":"LeaveAMessage","Mobile":mobile!,"Name_":"","Contact":textField.text!,"DeviceType":"1","Message_":textView.text]
            
        }
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                    self?.navigationController?.popViewControllerAnimated(true)
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }


        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "留言"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UITextView Delegate
    func textViewDidChange(textView: UITextView) {
        
        
        if (textView.text.characters.count == 0) {
            
            label.text = "在此输入";
            
        }else{
            
            label.text = "";
        }

    }
     

 

}
