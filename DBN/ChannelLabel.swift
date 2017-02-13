//
//  ChannelLabel.swift
//  网易新闻
//
//  Created by wl on 15/11/13.
//  Copyright © 2015年 wl. All rights reserved.
//  自定义label，用于频道显示

import UIKit

class ChannelLabel: UILabel {

    var scale: CGFloat = 0.0 {
        didSet {
            let content = NSMutableAttributedString(string: self.text!)

            if scale == 0 {
                
                self.textColor = UIColor.lxcolorWithHexString("#333333")
                let contentRange = NSMakeRange(0, 0)
                content.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(integer: 1), range: contentRange)
                attributedText = content;

            }else{
            
                self.textColor = LXColor(249, g: 98, b: 0, a: 1)
                let contentRange = NSMakeRange(0, content.length)
                content.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(integer: 1), range: contentRange)
                attributedText = content;

            }
            
            let s: CGFloat = 1 + scale * CGFloat(0.3)
            self.transform = CGAffineTransformMakeScale(s, s)
                        
            
        }
    }

}
