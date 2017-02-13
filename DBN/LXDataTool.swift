//
//  LXDataTool.swift
//  DBN
//
//  Created by 刘翔 on 16/10/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit
//import SwiftyJSON

let baseURL = "http://120.77.9.10:8001/api/app/get"

class LXDataTool: NSObject {
    
    
     class func getData(url:String!,_ parameters: [String: AnyObject],isHUD:Bool,finished:(result:[String : AnyObject]?)->())  {
        
    
        if isHUD == true {
            
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
            
        }

        let urlstr = baseURL + url
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
//        manager.requestSerializer = AFJSONRequestSerializer()
//        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")


//        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        

        manager.POST("http://120.77.9.10:8001/api/app/get", parameters: parameters, success: { (task, responseObject) in
            
            let time: NSTimeInterval = 1.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW,
                        Int64(time * Double(NSEC_PER_SEC)))
                    dispatch_after(delay, dispatch_get_main_queue()) {
            
                        SVProgressHUD.dismiss()
                    }
                 let dic = (try! NSJSONSerialization.JSONObjectWithData(responseObject! as! NSData, options: .AllowFragments)) as! NSDictionary
                    finished(result: dic as? [String : AnyObject])
            
            
            }) { (task,error) in
                SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
                            SVProgressHUD.setForegroundColor(UIColor.whiteColor())
                            SVProgressHUD.showErrorWithStatus("网络出错")
                
                            return
                
        }
        
    }
    
//    Alamofire.request(.POST, baseURL, parameters:parameters ).responseJSON {response in
//        
//        guard response.result.isSuccess else {
//            SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
//            SVProgressHUD.setForegroundColor(UIColor.whiteColor())
//            SVProgressHUD.showErrorWithStatus("网络出错")
//            
//            return
//        }
//        
//        
//        
//        let time: NSTimeInterval = 1.0
//        let delay = dispatch_time(DISPATCH_TIME_NOW,
//            Int64(time * Double(NSEC_PER_SEC)))
//        dispatch_after(delay, dispatch_get_main_queue()) {
// 
//            SVProgressHUD.dismiss()
//        }
//     let reslt = (try! NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)) as! NSDictionary
//        
//        finished(result: reslt as? [String : AnyObject])
//
//       
//        }
//    }
    
  
//    class func uploadImage(_ image:UIImage!,_ parameters: [String: AnyObject]!,isHUD:Bool,finished:@escaping (_ result:[String : AnyObject]?)->())  {
//        
//        if isHUD == true {
//            
//            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
//            SVProgressHUD.show(with: SVProgressHUDMaskType.black)
//            
//        }
//        
//        
//        Alamofire.upload(.POST, baseURL, multipartFormData: { (multipartFormData) in
//            
//            let data = UIImageJPEGRepresentation(image, 0.5)
//            let imageName = String(NSDate()) + ".png"
//            
//            //multipartFormData.appendBodyPart(data: ,name: ,fileName: ,mimeType: )这里把图片转为二进制,作为第一个参数
//            multipartFormData.appendBodyPart(data: data!, name: "file", fileName: imageName, mimeType: "image/png")
//            
//            
//            //遍历字典
//            for (key, value) in parameters {
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
//            }
//            
//        }) { (encodingResult) in
//            switch encodingResult {
//            case .Success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (response) in
//                    
//                        let time: NSTimeInterval = 1.0
//                        let delay = dispatch_time(DISPATCH_TIME_NOW,
//                            Int64(time * Double(NSEC_PER_SEC)))
//                        dispatch_after(delay, dispatch_get_main_queue()) {
//                            
//                            SVProgressHUD.dismiss()
//                        }
//                        
//                        let reslt = (try! NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)) as! NSDictionary
//                        
//                        finished(result: reslt as? [String : AnyObject])
//                       
//                })
//            case .Failure( _):
//                SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
//                SVProgressHUD.setForegroundColor(UIColor.whiteColor())
//                SVProgressHUD.showErrorWithStatus("网络出错")
//                
//                return
//            }
//        }
//        
//        
//            
//            //        if let value = response.result.value {
//            //                    let json = JSON(value)
//            //            print(json)
//            //                    let dataDict = json.dictionaryObject
//            //                    finished(result: dataDict)
//            //                }
//    }

    

}
