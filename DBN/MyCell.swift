//
//  MyCell.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prodocutImageView: UIImageView!
    
    var model:ProductListModel?{
    
        
        didSet{
        
            
//            self.prodocutImageView.sd_setImageWithURL()
            self.prodocutImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!), placeholderImage: UIImage(named: "暂无图片"))

            self.timeLabel.text = NSString(format: "%@",(model?.RegisteYear)!) as String
            self.numberLabel.text = model?.CertiNo
            self.nameLabel.text = model?.Name_
            self.placeLabel.text = model?.AreaName
            
        
        }
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
