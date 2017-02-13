//
//  HomeVC.swift
//  DBN
//
//  Created by Viatom on 16/9/23.
//  Copyright © 2016年 刘翔. All rights reserved.

import UIKit

private let cellID = "myCell"

class HomeVC: YMBaseViewController,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate {
    
    
//    品牌价值
    @IBAction func mapAC(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "品牌价值"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=BrandValue"
        navigationController?.pushViewController(VC, animated: true)

    }
    
    @IBAction func tapNew(sender: AnyObject) {
        let product = self.NewestProductList[0]
        let vc = DBDetailVC()
        vc.id = product.ID!
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func tapdetail(sender: AnyObject) {
        let product = self.NewestProductList[1]
        let vc = DBDetailVC()
        vc.id = product.ID!
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func nianDB(sender: AnyObject) {
        
//        navigationController?.pushViewController(NianDBVC(), animated: true)
        
        let VC = MapVC()
        VC.textStr = "产品评比"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=ProductGrade"
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    @IBAction func findDB(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "查地图"
        VC.url = "http://www.anluyun.com/Mobile/MapMark"
        navigationController?.pushViewController(VC, animated: true)

        
    }
    @IBOutlet weak var no1Label: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var placelabel1: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var NoLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    @IBAction func tap2(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "地标申请"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=AboutRegister"
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func tap1(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "地标追溯"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=AboutTrack"
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func tap3(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "地标常识"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=AboutLandMark"
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    @IBAction func mingYouAC(sender: AnyObject) {
        
        let VC = MapVC()
        VC.textStr = "示范基地"
        VC.url = "http://www.anluyun.com/Mobile/About?Key=ModelBase"
        navigationController?.pushViewController(VC, animated: true)

        
    }
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lxlayout: UICollectionViewFlowLayout!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    var circleView:SDCycleScrollView!
    var NewestProductList:[ProductListModel] = []
    var FamousProductList:[ProductListModel] = []
    var ViewedProductList:[ProductListModel] = []
    var QueryViewedProductList:[ProductListModel] = []


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        isfanhui = false
        addImageString("标题栏-查找")
        creatTitleView()
        
        
        let rect = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 75.0 * 34)
        circleView = SDCycleScrollView(frame: rect)
        circleView.delegate = self
        circleView.placeholderImage = UIImage(named: "")
        circleView.autoScrollTimeInterval = 3.0
        circleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        circleView.pageDotImage = UIImage(named: "详情-轮播标记2")
        circleView.currentPageDotImage = UIImage(named: "详情-轮播标记1")
        circleView.pageControlDotSize = CGSizeMake(8, 2)
        circleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        circleView.backgroundColor = UIColor.whiteColor()
        view1.addSubview(circleView)
        
        headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 75.0 * 34 + 610 - 134)
        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
//        tableView.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCellID")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerNib(UINib(nibName: "HCCell", bundle: nil), forCellWithReuseIdentifier: "cellid")
        
        lxlayout.minimumInteritemSpacing = 0
        lxlayout.minimumLineSpacing = 0
        lxlayout.scrollDirection = UICollectionViewScrollDirection.Vertical

        view2.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        view2.layer.borderWidth = 1
        view2.layer.cornerRadius = 5
        view2.layer.masksToBounds = true
    
        
        view3.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        view3.layer.borderWidth = 1
        view3.layer.cornerRadius = 5
        view3.layer.masksToBounds = true
        
        
        loadData()
//        loadQueryViewedProductList()
        
    }
  
    
    
    //SDCycleScrollViewDelegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        

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
                    self?.QueryViewedProductList = modelTool.objectsWithArray(array, cls: ProductListModel.self) as! [ProductListModel]
                    self?.tableView.reloadData()
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
                
    }

    
    func loadData(){
    
        
        let params:[String : AnyObject] = ["Type":"HomePage","Mobile":""]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                  let imageUrls = result!["Banners"] as! NSArray
//                  var  imageUrls = ["http://www.guaiguai.com/images/bodybg.jpg","http://www.guaiguai.com/images/bodybg.jpg"]
                    self!.circleView.imageURLStringsGroup = imageUrls as [AnyObject];
                    print(imageUrls)

                    let count = result!["TotalProductCount"] as! NSNumber
                    let countStr = count.stringValue
                    let uname:String = String(format: "已有%@个农产品申请地标",countStr)
                    var myMutableString = NSMutableAttributedString()
                    
                    myMutableString = NSMutableAttributedString(string: uname, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14.0)])
                    myMutableString.addAttribute(NSForegroundColorAttributeName, value:LXColor(249, g: 98, b: 0, a: 1), range:NSRange(location: 2,length:countStr.characters.count))
                    self?.totalCountLabel.attributedText = myMutableString
                    
                    //解析数据
                    let news = result!["NewestProductList"] as! NSArray
                    let famous = result!["FamousProductList"] as! NSArray
                    let vieweds = result!["ViewedProductList"] as? NSArray
                    
                    
                    let modelTool = DictModelManager.sharedManager
                    
                    self?.NewestProductList = modelTool.objectsWithArray(news, cls: ProductListModel.self) as! [ProductListModel]
                    self?.FamousProductList = modelTool.objectsWithArray(famous, cls: ProductListModel.self) as! [ProductListModel]
                    if (vieweds == nil){
                    
                         self?.ViewedProductList = modelTool.objectsWithArray(vieweds!, cls: ProductListModel.self) as! [ProductListModel]
                    
                    }
                    
                   
                    self?.collectionView.reloadData()
                    
                    let product = self?.NewestProductList[0]
                    let str = (product?.AreaName)! as String
                    let name = (product?.Name_)! as String
                    
                    let product1 = self?.NewestProductList[1]
                    let str1 = (product1?.AreaName)! as String
                    let name1 = (product1?.Name_)! as String
                    
//                    var char = "\n"
//
//                    str.insertContentsOf(char.characters, at: str.startIndex.advancedBy(str.characters.count / 2))
//                    name?.insertContentsOf(char.characters, at: (name?.startIndex.advancedBy((name?.characters.count)! / 2))!)
                    
                    
                    if name.characters.count > 6{
                        
                        self?.nameLabel.text = name.substringToIndex(name.startIndex.advancedBy(6))
                        
                    }else{
                        self?.nameLabel.text = name
                    }

//                    self?.nameLabel.text = name
                    self?.placeLabel.text = str
                    self?.NoLabel.text = product?.CertiNo
                    
                    if name1.characters.count > 6{
                    
                        self?.nameLabel1.text = name1.substringToIndex(name1.startIndex.advancedBy(6))
                        
                    }else{
                    self?.nameLabel1.text = name1
                    }
                    self?.placelabel1.text = str1
                    self?.no1Label.text = product1?.CertiNo
                    
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }

        
    
    }
    
    //mark CirCleViewDelegate
    func clickCurrentImage(currentIndxe: Int){
    
        print("khfpiq")
    
    }

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.FamousProductList.count > 6 {
            
            return 6
            
        }else{
            
             return self.FamousProductList.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellid", forIndexPath: indexPath) as! HCCell
        
        
        cell.model = self.FamousProductList[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model = self.FamousProductList[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width:(kScreenWidth - 40 - 30) / 3.0 , height: (kScreenWidth - 40 - 30) / 3.0 / 200 * 150 + 25)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    
    
    func creatTitleView(){
        
        let titleImage = UIImageView()
        titleImage.frame = CGRectMake((kScreenWidth - 240/2.0) / 2.0, 32, 240/2.0, 20)
        titleImage.image = UIImage(named:"首页标题栏")
        nav?.addSubview(titleImage);
        
        
        let titleImage1 = UIImageView()
        titleImage1.frame = CGRectMake(10, 24, 31.5, 31.5)
        titleImage1.image = UIImage(named:"首页标题栏Logo")
        nav?.addSubview(titleImage1);
        
    }
    
   override func rightAC() -> () {
        
        navigationController?.pushViewController(ScanVC(), animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeCell
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil)!.first as! HomeCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.None //UITableViewCellSelectionStyleNone
        }

        cell!.model = self.QueryViewedProductList[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
            if (tableView == self.tableView) {
                
                var addLine = false
                cell.backgroundColor = UIColor.clearColor();
                
                let layer = CAShapeLayer();
                
                let pathRef = CGPathCreateMutable();
                
                let bounds = CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0);
                
                
                if (indexPath.row == 0 && indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1) {
                    
                    
                
                    CGPathAddRoundedRect(pathRef, nil, CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0), 5, 5)
                    
                    
                } else if (indexPath.row == 0) {
                    
                    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)));
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMidX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 2), 9, 0)), 5);
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMidY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), 5);
                    
                    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0)));
                    
                    addLine = true
                } else if ( indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1) {
                    
                    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(bounds));
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(bounds), CGRectGetMidX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), 5);
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 0), 9, 0)), CGRectGetMaxY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMidY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), 5);
                    
                    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)), CGRectGetMinY(CGRectInset(CGRectMake(0, 0, cell.width, cell.height + 1), 9, 0)));
                    
                } else {
                    
                    CGPathAddRect(pathRef, nil, CGRectInset(CGRectMake(0, -1, cell.width, cell.height + 1), 9, 0));
                    addLine = true

                    
                }
                
                layer.path = pathRef;
                layer.fillColor = UIColor.lxcolorWithHexString("#dddddd").CGColor;
                let textView = UIView()
                textView.frame = bounds
                textView.layer.insertSublayer(layer, atIndex: 0)
                textView.backgroundColor = UIColor.clearColor()
                cell.backgroundView = textView
                
                
            }
        
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.frame = CGRectMake(0, 0, kScreenWidth, 30)
        view.backgroundColor = UIColor.clearColor()
        
//        let label = UILabel()
//        label.backgroundColor = UIColor.clearColor()
//        label.frame = CGRectMake(0, 0, kScreenWidth, 30)
//        label.text = "浏览记录"
//        label.font = UIFont.systemFontOfSize(12)
//        label.textColor = UIColor.lxcolorWithHexString("#666666")
//        label.textAlignment = .Center
//        view.addSubview(label)
        
        return view
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let model = self.QueryViewedProductList[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)

    }

    
    

}














