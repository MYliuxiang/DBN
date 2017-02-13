//
//  HHModel.swift
//  DBN
//
//  Created by Viatom on 16/10/11.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class HHModel: NSObject {

    var text:String?
    var value:String?
    var children:NSArray?
   
    override func objectClassInArray() -> [String:String]{
        return ["children":"city"]
    }
    override var description: String {
        return "name = \(text),value = \(value)"
    }

}

class city:NSObject{
    
    var text:String?
    var value:String?
    var children:NSArray?
    
    override func objectClassInArray() -> [String:String]{
        return ["children":"area"]
    }
    override var description: String {
        return "text = \(text),age = \(value)"
    }

}
class area:NSObject {
    var text:String?
    var value:String?
   
    override var description: String {
        return "text = \(text),age = \(value)"
    }


}