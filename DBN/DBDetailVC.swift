//
//  DBDetailVC.swift
//  DBN
//
//  Created by Viatom on 16/10/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit
private let cellID = "myCell"

class DBDetailVC: YMBaseViewController,UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate {

    @IBAction func zanAC(sender: AnyObject) {
        
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        
        if (mobile == nil) {
            //未登录
            
            let alert = UIAlertController(title: "您还未登陆", message:"是否前往登陆！" , preferredStyle: .Alert)
            let okaction = UIAlertAction(title: "确定", style: .Default) { (action) in
                
                let vc = LoginVC()
                let navVC = YMNavigationController(rootViewController:vc)
                self.presentViewController(navVC, animated: true, completion: nil)
                
            }
            let cancalAction = UIAlertAction(title: "取消", style: .Default) { (action) in
                
                
            }
            alert.addAction(cancalAction)
            alert.addAction(okaction)
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
            
        }else{
            
            var params:[String : AnyObject]
            
            params = ["Type":"Like","Mobile":mobile!,"ProductID":id]
            
            LXDataTool.getData("url",params,isHUD: false){ [weak self](result) in
                
                if result != nil {
                    if (result!["State"] as! String == "True") {
                        
                        SVProgressHUD.showSuccessWithStatus("点赞成功")
                        
                    }else{
                        //失败
                        SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                        
                    }
                }
                
            }
            
        }

        
    }
    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet var header: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var id:String = ""
    var findProductList = []
    var model:ProductModel?

    @IBAction func shouCAC(sender: AnyObject) {
        
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        
        if (mobile == nil) {
        //未登录
            
            let alert = UIAlertController(title: "您还未登陆", message:"是否前往登陆！" , preferredStyle: .Alert)
            let okaction = UIAlertAction(title: "确定", style: .Default) { (action) in
                
                let vc = LoginVC()
                let navVC = YMNavigationController(rootViewController:vc)
               self.presentViewController(navVC, animated: true, completion: nil)
                
            }
            let cancalAction = UIAlertAction(title: "取消", style: .Default) { (action) in
                
            
            }
            alert.addAction(cancalAction)
            alert.addAction(okaction)
            self.presentViewController(alert, animated: true, completion: {
                
            })
            
        
        }else{
            
            var params:[String : AnyObject]

            params = ["Type":"View","Mobile":mobile!,"ProductID":id]
            
            LXDataTool.getData("url",params,isHUD: false){ [weak self](result) in
                
                if result != nil {
                    if (result!["State"] as! String == "True") {
                        
                        
                        SVProgressHUD.showSuccessWithStatus("收藏成功")
                        
                    }else{
                        //失败
                        SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                        
                    }
                }

             }
        
        }
        
    }
    
    @IBAction func shareAC(sender: AnyObject) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "地标详情"
        let rect = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 75.0 * 34)
        header.frame = rect;
      
//        tableView.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: cellID)

        
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //SDCycleScrollViewDelegate点击轮播图
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        
    }
    
    func loadData(){
    
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        var params:[String : AnyObject]
        
        if (mobile == nil) {
            
            params = ["Type":"QueryProductDetail","Mobile":"","ProductID":id]
            
        }else{
            
            params = ["Type":"QueryProductDetail","Mobile":mobile!,"ProductID":id]
            
        }
        
        LXDataTool.getData("url",params,isHUD: false){ [weak self](result) in
            
            if result != nil {
                
                print(result)
                if (result!["State"] as! String == "True") {
                    
                    //解析数据
                    let dic = result!["Product"] as! NSDictionary
                    let modelTool = DictModelManager.sharedManager
                    self?.model = modelTool.objectWithDictionary(dic, cls: ProductModel.self) as? ProductModel
                    self?.tableView.reloadData()
                    
                  let  circleView = SDCycleScrollView(frame: CGRectMake(0, 0, kScreenWidth, kScreenWidth / 75.0 * 34))
                    circleView.delegate = self
                    circleView.placeholderImage = UIImage(named: "")
                    circleView.autoScrollTimeInterval = 3.0
                    circleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
                    circleView.pageDotImage = UIImage(named: "详情-轮播标记2")
                    circleView.currentPageDotImage = UIImage(named: "详情-轮播标记1")
                    circleView.pageControlDotSize = CGSizeMake(8, 2)
                    circleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
                    circleView.backgroundColor = UIColor.whiteColor()
                    
                    
                    let imageUrls = dic["Pics"] as! NSArray
                    
                    
//                    circleView.imageURLStringsGroup = self?.model?.Pics
                    
//                    print(self?.model?.Pics)
                    print(imageUrls)
                    if imageUrls.count == 0 {
                    
                        
                    }else{
                    
                        
                        circleView.imageURLStringsGroup = imageUrls as [AnyObject];

//                      circleView.imageURLStringsGroup = ["http://www.anluyun1688.com/MobileContent/Images/banner2.JPG"];
                        self?.tableView.tableHeaderView = self!.header
                        self?.headerView.addSubview(circleView)

                        
                    }

                    
//                    self!.loadQueryViewedProductList()
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }

        
    
    }
    
    
    func loadQueryViewedProductList(){
        
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        var params:[String : AnyObject]
        
        if (mobile == nil) {
            
            params = ["Type":"QueryViewedProductList","Mobile":"","Count":"10"]
            
        }else{
            
            params = ["Type":"QueryViewedProductList","Mobile":mobile!,"Count":"10"]
            
        }
        
        LXDataTool.getData("url",params,isHUD: false){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                    //解析数据
                    let array = result!["ProductList"] as! NSArray
                    let modelTool = DictModelManager.sharedManager
                    let array3 = modelTool.objectsWithArray(array, cls: ProductListModel.self)
                    let oo = array3![0] as! ProductListModel
                    self?.findProductList = array3!
                    self?.tableView.reloadData()
                    
                }else{
                    
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
        
    }

    
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            
            if (self.model == nil) {
                return 0
            }
            return 1
            
        }else if section == 1 {
            
            if (self.model == nil) {
                return 0
            }
            return 2
            
        }else if section == 2{
            
            if (self.model == nil) {
                return 0
            }
            
            return (self.model?.DetailTitles?.count)!
            
        }else{
        
            return 0
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let identifier="identtifier";
            var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
            if(cell == nil){
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                
            }
            cell?.textLabel?.text = self.model?.Name_
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.textLabel?.textColor = UIColor.lxcolorWithHexString("#333333")
            cell?.detailTextLabel?.text = self.model?.AreaName
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(12)
            cell?.detailTextLabel?.textColor = UIColor.lxcolorWithHexString("#666666")
            
            return cell!;
            
        }else if indexPath.section == 1{
        
            let identifier="identtifier1";
            var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
            if(cell == nil){
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                
            }
            let names = ["编号","公布日期"]
            let strs = [self.model?.CertiNo,self.model?.RegisteYear]
            cell?.textLabel?.text = names[indexPath.row]
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.textLabel?.textColor = UIColor.lxcolorWithHexString("#333333")
            switch indexPath.row {
            case 0:
                
                cell?.detailTextLabel?.text = self.model?.CertiNo

                break
            case 1:
                
                cell?.detailTextLabel?.text = String(format: "%@",(self.model?.RegisteYear)!)

                break
            default:
                break
            }
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(12)
            cell?.detailTextLabel?.textColor = UIColor.lxcolorWithHexString("#666666")
            
            return cell!;
            
        } else if indexPath.section == 2{
        
            let identifier="identtifier2";
            var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
            if(cell == nil){
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            cell?.textLabel?.text = self.model?.DetailTitles![indexPath.row]
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.textLabel?.textColor = UIColor.lxcolorWithHexString("#333333")
            cell?.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
            return cell!;
            
        }else{
        
            let identifier="identtifier";
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeCell
            if(cell == nil) {
                cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil)!.first as! HomeCell
                cell?.selectionStyle = UITableViewCellSelectionStyle.None //UITableViewCellSelectionStyleNone
            }
            
            cell!.model = self.findProductList[indexPath.row] as! ProductListModel
            
            return cell!

       
        }
        
    }
    
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if (indexPath.section == 3) {
//            
//            cell.backgroundColor = UIColor.clearColor();
//            let layer = CAShapeLayer();
//            let pathRef = CGPathCreateMutable();
//            let bounds = CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0);
//            if (indexPath.row == 0 && indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1) {
//                
//                CGPathAddRoundedRect(pathRef, nil, CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0), 5, 5)
//                
//            } else if (indexPath.row == 0) {
//                
//                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)));
//                
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMidX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0)), 5);
//                
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMidY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), 5);
//                
//                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)));
//                
//            } else if ( indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1) {
//                
//                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(bounds));
//                
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(bounds), CGRectGetMidX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), 5);
//                
//                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 0), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMidY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), 5);
//                
//                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)));
//                
//            } else {
//                
//                CGPathAddRect(pathRef, nil, CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0));
//                
//            }
//            layer.path = pathRef;
//            layer.fillColor = UIColor.lxcolorWithHexString("#dddddd").CGColor;
//            
//            let textView = UIView()
//            textView.frame = bounds
//            textView.layer.insertSublayer(layer, atIndex: 0)
//            textView.backgroundColor = UIColor.clearColor()
//            cell.backgroundView = textView
//            
//            
//        }
//        
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (self.findProductList.count != 0) {
            
            if section == 3 {
                let view = UIView()
                view.frame = CGRectMake(0, 0, kScreenWidth, 30)
                view.backgroundColor = UIColor.clearColor()
                
//                let label = UILabel()
//                label.backgroundColor = UIColor.clearColor()
//                label.frame = CGRectMake(0, 0, kScreenWidth, 30)
//                label.text = "浏览记录"
//                label.font = UIFont.systemFontOfSize(12)
//                label.textColor = UIColor.lxcolorWithHexString("#666666")
//                label.textAlignment = .Center
//                view.addSubview(label)
                
                return view
            }

        }
        
        return UIView()
        
    }

    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0.1
        }else{
        return 0.1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return 100
        }
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 2 {
            
            let vc = DBDetailText()
            vc.text = self.model?.DetailTitles![indexPath.row]
            vc.titlesArray = (self.model?.DetailTitles)!
            vc.contentArray = (self.model?.Details)!
            vc.ProductID = (self.model?.ID)!
            vc.index = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
        
        if indexPath.section == 3 {
            
            
            let model = self.findProductList[indexPath.row] as! ProductListModel
            let vc = DBDetailVC()
            vc.id = model.ID!
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
  

}

extension DBDetailVC:CirCleViewDelegate{


    func clickCurrentImage(currentIndxe: Int){
    
    
    }


}

