//
//  ProductListModel.swift
//  DBN
//
//  Created by 刘翔 on 16/10/18.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class ProductListModel: NSObject {

    
    var ID:String?
    var Name_:String?
    var Kind1:String?
    var Kind2:String?
    var LikeCount:NSNumber?
    var ViewCount:NSNumber?
    var RegisteYear:NSNumber?
    var AreaName:String?
    var CertiNo:String?
    var Owner:String?
    var LogoUrl:String?
    
       
}

class ProductModel: NSObject {
    
    var ID:String?
    var Name_:String?
    var Kind1:String?
    var Kind2:String?
    var LikeCount:NSNumber?
    var ViewCount:NSNumber?
    var RegisteYear:NSNumber?
    var AreaName:String?
    var CertiNo:String?
    var Owner:String?
    var LogoUrl:String?
    var Pics:[String]?
    var DetailTitles:[String]?
    var Details:[String]?
    
}

