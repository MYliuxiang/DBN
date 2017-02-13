//
//  InformationVC.swift
//  DBN
//
//  Created by Viatom on 16/9/23.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class InformationVC: YMBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    var tableHeaderView:UIImageView!
    var bottomLabel:UILabel!
    var dataList:NSArray = NSArray()
    var headerdic:Dictionary<String,AnyObject> = Dictionary()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        text = "资讯"
        creatTable()
        creatTableHeaderView()
        loadData()
    }
    
    // MARK : - tableView
    func creatTable(){
        
        tableView=UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49),style:UITableViewStyle.Plain);
        tableView!.delegate=self;
        tableView!.dataSource=self;
        tableView?.rowHeight = 194
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.None;
        tableView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableView!);
    }
    
    func creatTableHeaderView() {
        
        let rect = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 75.0 * 34)  /** 图片 */
        let imageView = UIImageView(frame: rect)
        tableHeaderView = imageView
        imageView.userInteractionEnabled = true
        tableHeaderView.backgroundColor = UIColor.whiteColor()
        tableView.tableHeaderView = tableHeaderView
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(InformationVC.tap))
        imageView.addGestureRecognizer(tap)
        
        
        bottomLabel = UILabel(frame:CGRectMake(20, kScreenWidth / 75.0 * 34 - 30, kScreenWidth - 20,30 ))
        bottomLabel.font = UIFont.systemFontOfSize(15)
        bottomLabel.textAlignment = NSTextAlignment.Left
        bottomLabel.text = " "
        bottomLabel.textColor = UIColor.whiteColor()
        tableHeaderView .addSubview(bottomLabel)
        
    }
    
    
    func tap(){
    
        let Url =  self.headerdic["Url"] as! String
        let infoDetailVC :InformationDetailViewController = InformationDetailViewController()
        infoDetailVC.url = (Url as? String)!
        navigationController?.pushViewController(infoDetailVC, animated: true)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? InformationTableViewCell
        if(cell == nil) {
            cell = InformationTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None //UITableViewCellSelectionStyleNone
        }
        
        let temArr = self.dataList as? NSArray
        if temArr != nil {
            cell?.dataList = temArr![indexPath.row] as! NSArray
        }
        //arc4random arc4random_uniform 函数求一个1~255的随机数（包括1和255）
        //        let temp:Int = Int(arc4random()%255)+1
        //        let temps:Int = Int(arc4random_uniform(255))+1
        //        let rgb:CGFloat = CGFloat(temp) / 255.0
        //        let rgb2:CGFloat = CGFloat(temps) / 255.0
        //        cell!.backgroundColor = UIColor(red: rgb, green: rgb2, blue: rgb, alpha: 1.0)
        return cell!
    
        
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 网络请求
    func loadData () {
        
        let params:[String : AnyObject] = ["Type":"QueryNews","Mobile":""]
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            print(result)
            if result != nil {
                if (result!["State"] as! String == "True") {
                    let dataArray = result!["News"]     //tableView数据
                    var temArr = dataArray as? NSArray
                    if temArr?.count > 0 {
                        let dic = temArr![0]
                        self?.headerdic = dic as! [String : AnyObject]
                        let Pic =  dic .objectForKey("Pic")
                        var url:NSURL!
                        url = NSURL(string: (Pic as? String)!)
//                        self!.tableHeaderView.sd_setImageWithURL(url)
                        self!.tableHeaderView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "暂无图片"))
                        let title =  dic .objectForKey("Title_")
                        self!.bottomLabel.text = title as? String
                    }
                    
                    
                    
                    let nsArray4 = NSMutableArray(array: temArr!)
                    nsArray4 .removeObjectAtIndex(0)
                    temArr = nsArray4 as NSArray        /*总过七条数据，把第一条放到headerView*/
                    
                    let arrays:NSMutableArray = NSMutableArray() // 创建二维数组
                    var array1:NSMutableArray = NSMutableArray()//小数组
                    
                    for var index:NSInteger = 0; index  < temArr?.count ; index += 1  {
                      
                        if index % 3 == 0 {
                            array1 = NSMutableArray()
                            arrays.addObject(array1)
                        }
                        
                        let cellDic =  temArr![index]
                        let dic  = cellDic as! NSDictionary
                        array1.addObject(dic)
                        
                    }
                    self?.dataList = arrays
                    self?.tableView.reloadData()
                    
//                    if temArr?.count > 0 {
//                        let dic = temArr![0]
//                        let Pic =  dic .objectForKey("Pic")
//                        var url:NSURL!
//                        url = NSURL(string: (Pic as? String)!)
//                        self!.tableHeaderView.sd_setImageWithURL(url)
//                    }
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                }
            }
        }
    }
  
}


