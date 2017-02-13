//
//  LXConst.swift
//  DBN
//
//  Created by 刘翔 on 16/9/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

//账号密码  13902925960，1234  svn http://code.taobao.org/svn/lxdemo/


//常用属性
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
let kVersion = float_t(UIDevice.currentDevice().systemVersion)
let referenceBoundsHeight:CGFloat = 667.0
let referenceBoundsWight:CGFloat = 375.0
let ratioHeight = kScreenHeight / referenceBoundsHeight
let ratioWidth = kScreenWidth / referenceBoundsWight


let TOKEN = "token"
let DeviceID = "DeviceID"
let HeadImage = "HeadImage"
let UserID = "ID"
let Name = "Name"
let Sex = "Sex"
let Mobile = "Mobile"
let FavoritesCount = "FavoritesCount"
let ViewCount = "ViewCount"





/// RGBA的颜色设置
func LXColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


let Login = "login"














