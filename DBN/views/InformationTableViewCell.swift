//
//  InformationTableViewCell.swift
//  DBN
//
//  Created by administrator on 2016/10/13.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    var leftTieleView:UIView!
    var rightTieleView:UIView!
    var bottomTieleView:UIView!
    
    //属性监视器
    var dataList:NSArray = NSArray() {
        willSet(newDataList) {
            
            self.showData(newDataList)
        }
        didSet {
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.whiteColor()
        setUpViews()
        
    }
    
    /**
     *viewController () -> (UIViewController) 作用：根据调用这个方法的对象 来 获取他的控制器对象
     */
    func viewController () -> (UIViewController){
        
        /* 方法1.
         //1.通过响应者链关系，取得此视图的下一个响应者
         var next:UIResponder?
         next = self.nextResponder()!
         while next != nil {
         //2.判断响应者对象是否是视图控制器类型
         if ((next as?UIViewController) != nil) {
         return (next as! UIViewController)
         
         }else {
         next = next?.nextResponder()
         }
         }
         
         return UIViewController()
         */
        
        //1.通过响应者链关系，取得此视图的下一个响应者
        var next:UIResponder?
        next = self.nextResponder()!
        repeat {
            //2.判断响应者对象是否是视图控制器类型
            if ((next as?UIViewController) != nil) {
                return (next as! UIViewController)//类型的转换
                
            }else {
                next = next?.nextResponder()
            }
            
        } while next != nil
        
        return UIViewController()
    }

    func tapAction1(tap1: UITapGestureRecognizer) {
        print("点击了1")
        if self.dataList.count >= 1 {
            let dic = self.dataList .objectAtIndex(0)
            let Url =  dic .objectForKey("Url")
            let infoDetailVC :InformationDetailViewController = InformationDetailViewController()
            infoDetailVC.url = (Url as? String)!
            let firVC:UIViewController =  self.viewController()
            firVC.navigationController?.pushViewController(infoDetailVC, animated: true)
        }
        
    }
    
    func tapAction2(tap2: UITapGestureRecognizer) {
        print("点击了2")
        if self.dataList.count >= 2 {
            let dic = self.dataList .objectAtIndex(1)
            let Url =  dic .objectForKey("Url")
            let infoDetailVC :InformationDetailViewController = InformationDetailViewController()
            infoDetailVC.url = (Url as? String)!
            let firVC:UIViewController =  self.viewController()
            firVC.navigationController?.pushViewController(infoDetailVC, animated: true)
        }
        
    }
    func tapAction3(tap3: UITapGestureRecognizer) {
        print("点击了3")
        if self.dataList.count >= 3 {
            let dic = self.dataList .objectAtIndex(2)
            let Url =  dic .objectForKey("Url")
            let infoDetailVC :InformationDetailViewController = InformationDetailViewController()
            infoDetailVC.url = (Url as? String)!
            let firVC:UIViewController =  self.viewController()
            firVC.navigationController?.pushViewController(infoDetailVC, animated: true)
        }
    }
    
    //MARK: -  setUp Views
    func setUpViews () {
        let rect1 = CGRectMake(0, 0, kScreenWidth/2.0, 194/2.0 )
        leftTieleView = UIView(frame: rect1)
        leftTieleView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(leftTieleView)
        creatSubViewWithParams(leftTieleView, rect: CGRectMake(17, 40/2.0, kScreenWidth/2.0 - 34, 40))
        let tap1 = UITapGestureRecognizer(target: self, action: (#selector(InformationTableViewCell.tapAction1(_:))))
        leftTieleView.addGestureRecognizer(tap1)
        
        let rect2 = CGRectMake(kScreenWidth/2.0, 0, kScreenWidth/2.0, 194/2.0)
        rightTieleView = UIView(frame: rect2)
        rightTieleView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(rightTieleView)
        creatSubViewWithParams(rightTieleView, rect: CGRectMake(17 , 40/2.0, kScreenWidth/2.0 - 34, 40))
        let tap2 = UITapGestureRecognizer(target: self, action: (#selector(InformationTableViewCell.tapAction2(_:))))
        rightTieleView.addGestureRecognizer(tap2)

        
        let rect3 = CGRectMake(0, 194/2.0, kScreenWidth, 194/2.0)
        bottomTieleView = UIView(frame: rect3)
        bottomTieleView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(bottomTieleView)
        creatSubViewWithParams(bottomTieleView, rect: CGRectMake(17 , 30/2.0 , kScreenWidth - 34, 40))
        let tap3 = UITapGestureRecognizer(target: self, action: (#selector(InformationTableViewCell.tapAction3(_:))))
        bottomTieleView.addGestureRecognizer(tap3)
        
        let rect4 = CGRectMake(kScreenWidth/2.0 - 0.25, 0, 0.5, 194/2.0 )
        let sepatateView = UIView(frame: rect4)
        sepatateView.backgroundColor = UIColor(red: 220/255.0, green: 221/255.0, blue: 222/255.0, alpha: 1)
        self.contentView.addSubview(sepatateView)
        
        let rect5 = CGRectMake(0, 194/2.0, kScreenWidth, 0.5 )
        let sepatateView2 = UIView(frame: rect5)
        sepatateView2.backgroundColor = UIColor(red: 220/255.0, green: 221/255.0, blue: 222/255.0, alpha: 1)
        self.contentView.addSubview(sepatateView2)
        
        let rect6 = CGRectMake(0, 0, kScreenWidth, 0.5 )
        let sepatateView3 = UIView(frame: rect6)
        sepatateView3.backgroundColor = UIColor(red: 220/255.0, green: 221/255.0, blue: 222/255.0, alpha: 1)
        self.contentView.addSubview(sepatateView3)
    }
    
    func creatSubViewWithParams(viewOfSuperView:UIView,rect:CGRect) {
    
        let titleLabel = UILabel(frame: rect)
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.lxcolorWithHexString("#333333")
        titleLabel.tag = 100;
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.text = ""
        titleLabel.numberOfLines = 0
//        titleLabel .sizeToFit()
        viewOfSuperView.addSubview(titleLabel)
        
        
        let dateLabel = UILabel(frame: CGRectMake(titleLabel.x , titleLabel.y + titleLabel.height, kScreenWidth/2.0 - 34 , 12))
        dateLabel.text = ""
        dateLabel.tag = 101
        dateLabel.numberOfLines = 0;
//        dateLabel.sizeToFit()
        dateLabel.backgroundColor = UIColor.whiteColor()
        dateLabel.font = UIFont.systemFontOfSize(11)
        dateLabel.textColor = UIColor.lxcolorWithHexString("#999999")
        viewOfSuperView .addSubview(dateLabel)
        
        
    }
   
    
    //MARK: - 显示数据
    func showData(result:NSArray) {

        if result.count == 0 {
            print("个数为0")
        }else if result.count == 1 {
            loadThreeViewData(result, index: 0, viewOfSuperView: leftTieleView)

        }else if result.count == 2 {
            loadThreeViewData(result, index: 0, viewOfSuperView: leftTieleView)
            loadThreeViewData(result, index: 1, viewOfSuperView: rightTieleView)

        }else {
            
            loadThreeViewData(result, index: 0, viewOfSuperView: leftTieleView)
            loadThreeViewData(result, index: 1, viewOfSuperView: rightTieleView)
            loadThreeViewData(result, index: 2, viewOfSuperView: bottomTieleView)
            

        }
    }
    
    func loadThreeViewData(result:NSArray ,index:Int ,viewOfSuperView:UIView) {
    

        let dic = result .objectAtIndex(index)
        let title =  dic .objectForKey("Title_")
        let view = viewOfSuperView.viewWithTag(100)
    
        if (view as? UILabel) != nil {     //view －－－> UILabel
            let titleLabel = view as! UILabel
            titleLabel.text = title as? String
        }
        
        let LastEditTime =  dic .objectForKey("LastEditTime")
        let view2 = viewOfSuperView.viewWithTag(101)
        if (view2 as? UILabel) != nil {     //view －－－> UILabel
            let dateLalble = view2 as! UILabel
            dateLalble.text = LastEditTime as? String


        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    func rectHeightWithStr(str:NSString,fontFloat:CGFloat,WithStrWidth:CGFloat) -> CGRect {
////        let rect:CGRect = str.
//        let font = UIFont.systemFontOfSize(fontFloat)
//        
//        [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];    }
//    
//    - (CGRect)rectHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)width
//    {
//    CGRect fcRect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat]} context:nil];
//    return fcRect;
//    }

    
    
   

}
