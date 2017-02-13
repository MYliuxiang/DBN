//
//  UIColor+Extension.swift
//  DBN
//
//  Created by 刘翔 on 16/9/28.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

extension UIColor {

  class  func lxcolorWithHexString ( Color_Value:String)->UIColor{
        var  Str :NSString = Color_Value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if Color_Value.hasPrefix("#"){
            Str=(Color_Value as NSString).substringFromIndex(1)
        }
        let ZSJ_StrRed = (Str as NSString ).substringToIndex(2)
        let ZSJ_StrGreen = ((Str as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let ZSJ_StrBlue = ((Str as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string:ZSJ_StrRed).scanHexInt(&r)
        NSScanner(string: ZSJ_StrGreen).scanHexInt(&g)
        NSScanner(string: ZSJ_StrBlue).scanHexInt(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
}
