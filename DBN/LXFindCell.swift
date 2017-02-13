//
//  LXFindCell.swift
//  DBN
//
//  Created by 刘翔 on 16/10/27.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class LXFindCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var placelabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
    }

    
    @IBOutlet weak var btn: UIButton!
    var model:ProductListModel?{
        
        didSet {
            
            print(model)
            //            self.logoImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!))
//            self.logoImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!), placeholderImage: UIImage(named: "2"))
            
            self.timeLabel.text = NSString(format: "%@",(model?.RegisteYear)!) as String
            self.noLabel.text = model?.CertiNo
            self.nameLabel.text = model?.Name_
            self.placelabel.text = model?.AreaName
            self.peopleLabel.text = model?.Owner
            
        }
        
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
