//
//  DetailTextCell.swift
//  DBN
//
//  Created by 刘翔 on 16/10/19.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class DetailTextCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
