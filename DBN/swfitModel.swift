//
//  swfitModel.swift
//  DBN
//
//  Created by Viatom on 16/10/11.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class swfitModel: NSObject ,DictModelProtocol{

    var text:String?
    var value:String?
    var children:[citys]?

    static func customClassMapping() -> [String : String]? {
        return ["children" : "\(citys.self)"]
        
    }

}



class citys:NSObject{
    
    var text:String?
    var value:String?
    var children:[areas]?
    
    static func customClassMapping() -> [String : String]? {
        return ["children" : "\(areas.self)"]
        
    }


}

class areas:NSObject {
    var text:String?
    var value:String?
    
    
}

class lxmodel:NSObject {
        var DeviceID:String?
        var HeadImage:String?
        var ID:String?
        var sex:String?
        var Mobile:String?
    static func customClassMapping() -> [String : String]? {
        return ["Mobile" : "\(String.self)"]
        
    }
    
    
}

