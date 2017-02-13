//
//  HomeCell.swift
//  DBN
//
//  Created by 刘翔 on 16/10/8.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var NoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var model:ProductListModel?{
        
        didSet {
            
            print(model)
//            self.logoImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!))
//            self.logoImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!), placeholderImage: UIImage(named: "2"))
            
            self.logoImageView.sd_setImageWithURL(NSURL(string: (model?.LogoUrl)!), placeholderImage: UIImage(named: "暂无图片"))

            
            self.timeLabel.text = NSString(format: "%@",(model?.RegisteYear)!) as String
            self.NoLabel.text = model?.CertiNo
            self.nameLabel.text = model?.Name_
            self.placeLabel.text = model?.AreaName
            
        }
        
    }
    
    
    @IBOutlet weak var placeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func corner(index:NSInteger){
    
        if index == 1 {
//            bgView.backgroundColor = UIColor.redColor()
            
            let maskPath = UIBezierPath.init(roundedRect: CGRectMake(0, 0, bgView.width , bgView.height ), byRoundingCorners: [UIRectCorner.TopLeft ,UIRectCorner.TopRight], cornerRadii: CGSizeMake(5, 5))
            let maskLayer = CAShapeLayer();
            maskLayer.frame = CGRectMake(0, 0, bgView.width , bgView.height );
            maskLayer.path = maskPath.CGPath;
            maskLayer.borderColor = UIColor.lxcolorWithHexString("#000000").CGColor
            maskLayer.borderWidth = 1
            maskLayer.cornerRadius = 5
            maskLayer.masksToBounds = true
            bgView.layer.mask = maskLayer;
//            bgView.layer.addSublayer(maskLayer);
            
        }else if index == 2{
            
            let maskPath = UIBezierPath.init(roundedRect: bgView.bounds, byRoundingCorners: [UIRectCorner.BottomLeft ,UIRectCorner.BottomRight], cornerRadii: CGSizeMake(5, 5))
            let maskLayer = CAShapeLayer();
            maskLayer.frame = bgView.bounds;
            maskLayer.path = maskPath.CGPath;
            bgView.layer.mask = maskLayer;
        
        }else{
            
            let maskPath = UIBezierPath.init(roundedRect: bgView.bounds, byRoundingCorners: [UIRectCorner.BottomLeft ,UIRectCorner.BottomRight], cornerRadii: CGSizeMake(0, 0))
            let maskLayer = CAShapeLayer();
            maskLayer.frame = bgView.bounds;
            maskLayer.path = maskPath.CGPath;
            maskLayer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
            maskLayer.borderWidth = 1
            bgView.layer.mask = maskLayer;
        
        }
        
//        bgView.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
//        bgView.layer.borderWidth = 1
    
    }
    
}
