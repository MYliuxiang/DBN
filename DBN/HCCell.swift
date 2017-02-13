//
//  HCCell.swift
//  DBN
//
//  Created by 刘翔 on 16/10/8.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class HCCell: UICollectionViewCell {

    var model:ProductListModel?{
    
        didSet {
            
            self.imageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!), placeholderImage: UIImage(named: "暂无图片"))
            self.label.text = model?.Name_
        }
    
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
