

import UIKit

class SingleGifColumnCell: UITableViewCell {

    @IBOutlet weak var titleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleBtn.setTitleColor(UIColor.lxcolorWithHexString("#333333"), forState: UIControlState.Normal)
        titleBtn.setTitleColor(UIColor.lxcolorWithHexString("#5a9e3b"), forState: UIControlState.Selected)
        
        titleBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.whiteColor(), size: CGSizeZero), forState: UIControlState.Normal)
        titleBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.lxcolorWithHexString("#f2f2f2"), size: CGSizeZero), forState: UIControlState.Selected)
    }
    
    func changeStatus(selected: Bool) {
        titleBtn.selected = selected
    }
}
