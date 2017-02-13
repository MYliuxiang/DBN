//
//  HHViewController.swift
//  DBN
//
//  Created by 刘翔 on 16/10/21.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class HHViewController: YMBaseViewController, DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UITableViewDelegate,UITableViewDataSource {

    var findData1 = [AnyObject]()
    var findData2 = [swfitModel]()
    
    var tableView: UITableView!
    var dataList:[ProductListModel] = []

    var currentData1Index = 0
    var currentData2Index = 0
    var seletcedIndex = DOPIndexPath(col: 0,row: 0,item: 0)
    var seletcedIndex1 = DOPIndexPath(col: 1,row: 0,item: 0)
    var isFirst = true

    lazy var menu = DOPDropDownMenu.init(origin: CGPointMake(0, 64), andHeight: 44)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"重新加载", style:UIBarButtonItemStyle.Plain, target:self, action:"menuReloadData")
        
        tableView = UITableView(frame: CGRectMake(0, 104, kScreenWidth, kScreenHeight - 64 - 40),style:UITableViewStyle.Grouped)
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: "LXFindCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cellID")

        self.view.addSubview(tableView);
        
                let path = NSBundle.mainBundle().pathForResource("area", ofType: "json")
                let data = NSData(contentsOfFile: path!)
                if data != nil {
                    let dict: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSArray
                    let modelTool = DictModelManager.sharedManager
                    let array = modelTool.objectsWithArray(dict,cls:swfitModel.self)
                    self.findData2 = array as! [swfitModel]
                }
        
        print(findData2)
        
        let model:swfitModel = swfitModel()
        model.text = "全部"
        model.value = "0190"
        self.findData2.insert(model, atIndex: 0)
        
        loadFindData()
        
    }
    
    func loadFindData(){
        
        let params:[String : AnyObject] = ["Type":"QueryKind"]
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                print(result)
                if (result!["State"] as! String == "True") {
                    
                    let array = result!["Kinds"] as! NSArray
                    
                    
                    if(array.count != 0){
                        
                        self?.findData1 = array as [AnyObject]
                        
                        // 添加下拉菜单
                        self!.menu.delegate = self
                        self!.menu.dataSource = self
                        self!.menu.textColor = UIColor.lxcolorWithHexString("#333333")
                        self!.menu.textSelectedColor = LXColor(88, g: 158, b: 59, a: 1)
                        self!.menu.backgroundColor = LXColor(228, g: 228, b: 228, a: 1)
                        self!.view.addSubview(self!.menu)
//                        self!.menu.selectIndexPath(self!.seletcedIndex1)
                        self!.menu.selectIndexPath(self!.seletcedIndex)

                        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
//                        self!.menu.selectDefalutIndexPath()
                        
                        let dic = self!.findData1[self!.seletcedIndex.row] as! NSDictionary
                        let name = dic.allKeys.first as! String
                        let array1 = dic.objectForKey(name) as! [String]
                        
//                        let model = self!.findData2[self!.seletcedIndex.row]
//                        let city = model.children![(self?.seletcedIndex.item)!]
                    }
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }

    }
    
    
    func loadData(kind1:String?,kind2:String?){
    
        
        var params:[String : AnyObject]
        if kind2 == nil {
            params = ["Type":"QueryProductList","AreaName":"","KindName":kind1!]

        }else{
            
            if kind2 == "全部" {
                
                params = ["Type":"QueryProductList","AreaName":"","KindName":kind1!]

            }else{
            
                
                params = ["Type":"QueryProductList","AreaName":kind2!,"KindName":kind1!]

            }
            
        }
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                if (result!["State"] as! String == "True") {
                    
                    //解析数据
                    let array = result!["ProductList"] as! NSArray
                    if(array.count != 0){
                        let modelTool = DictModelManager.sharedManager
                        self?.dataList = modelTool.objectsWithArray(array, cls: ProductListModel.self) as! [ProductListModel]
                        self?.tableView.reloadData()
                        
                    }else{
                    
                        self?.dataList.removeAll()
                        self?.tableView.reloadData()
                    }
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
        

    
    }
    
    
    func numberOfColumnsInMenu(menu: DOPDropDownMenu!) -> Int {
        
        return 2
    }
    
    func menu(menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        
        if (column == 0) {
            
            return self.findData1.count
        }else{
        
            
            return self.findData2.count
        }
        
    }
    
    
    func menu(menu: DOPDropDownMenu!, titleForRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        
        if (indexPath.column == 0) {
            
            let dic = self.findData1[indexPath.row] as! NSDictionary
            let name = dic.allKeys.first as! String
            return name;
            
        } else {
            
//            if isFirst {
//                
//                return "全部"
//            }
            
            let model = self.findData2[indexPath.row]
            return model.text
        }

        
    }
    
    func menu(menu: DOPDropDownMenu!, imageNameForRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        return nil
    }
    
    func menu(menu: DOPDropDownMenu!, imageNameForItemsInRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        return nil
    }
    
    func menu(menu: DOPDropDownMenu!, detailTextForRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        return nil
    }
    
    func menu(menu: DOPDropDownMenu!, detailTextForItemsInRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        return nil
    }
    
    func menu(menu: DOPDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
        
        if (column == 0) {
            
                    let dic = self.findData1[row] as! NSDictionary
                    let name = dic.allKeys.first as! String
                    let array1 = dic.objectForKey(name) as! [String]
                    return array1.count
        
                }else{
        
                    let model = self.findData2[row]
                    let array = model.children
                    if (array == nil){
        
                        return 0
                    }
                    return array!.count
        }
    }
    
    func menu(menu: DOPDropDownMenu!, titleForItemsInRowAtIndexPath indexPath: DOPIndexPath!) -> String! {
        
        if (indexPath.column == 0) {
            
                        let dic = self.findData1[indexPath.row] as! NSDictionary
                        let name = dic.allKeys.first as! String
                        let array1 = dic.objectForKey(name) as! [String]
                        return array1[indexPath.item]
            
                    }else{
            
                        let model = self.findData2[indexPath.row]
                        let city = model.children![indexPath.item]
            
                        return city.text
                    }

        
        
    }
    
    func menu(menu: DOPDropDownMenu!, didSelectRowAtIndexPath indexPath: DOPIndexPath!) {
        
      
               
        if (indexPath.column == 0) {
            
        
            if indexPath.item != -1 {
                
                self.seletcedIndex = indexPath
                if seletcedIndex1.item != -1 {
                    
                    let dic = self.findData1[self.seletcedIndex.row] as! NSDictionary
                    let name = dic.allKeys.first as! String
                    let array1 = dic.objectForKey(name) as! [String]
                    
                    let model = self.findData2[seletcedIndex1.row]
                    let array = model.children
                    if (array == nil){

                        loadData(array1[seletcedIndex.item], kind2: model.text)

                    }else{
                        
                    let city = model.children![(self.seletcedIndex1.item)]
                    loadData(array1[seletcedIndex.item], kind2: city.text)
                        
                    }
                    
                
                    
                }else{
                    
                    let model = self.findData2[seletcedIndex1.row]
                    let array = model.children
                    if (array == nil){
                        
                        let dic = self.findData1[self.seletcedIndex.row] as! NSDictionary
                        let name = dic.allKeys.first as! String
                        let array1 = dic.objectForKey(name) as! [String]
                        
                        let model = self.findData2[self.seletcedIndex1.row]
//                        loadData(array1[seletcedIndex.item], kind2: model.text)
                        
                    }


            
                }
            
            }
        }else{
            
            if indexPath.item != -1 {
                self.seletcedIndex1 = indexPath
                let dic = self.findData1[self.seletcedIndex.row] as! NSDictionary
                let name = dic.allKeys.first as! String
                let array1 = dic.objectForKey(name) as! [String]
                
                let model = self.findData2[seletcedIndex1.row]
                let array = model.children
                if (array == nil){
                    
                    loadData(array1[seletcedIndex.item], kind2: model.text)
                    
                }else{
                    let city = model.children![(self.seletcedIndex1.item)]
                    loadData(array1[seletcedIndex.item], kind2: city.text)
                }
                
            }else{
                
                let model = self.findData2[indexPath.row]
                let array = model.children
                if (array == nil){

                    self.seletcedIndex1 = indexPath
                    let dic = self.findData1[self.seletcedIndex.row] as! NSDictionary
                    let name = dic.allKeys.first as! String
                    let array1 = dic.objectForKey(name) as! [String]
                    
                    let model = self.findData2[self.seletcedIndex1.row]
                    loadData(array1[seletcedIndex.item], kind2: model.text)
                    
                }
            
            }
            
        }
        
    
    }
    
    
    
    
//    func numberOfColumnsInMenu(menu: JSDropDownMenu!) -> Int {
//        
//        return 2
//    }
//    
//    func displayByCollectionViewInColumn(column: Int) -> Bool {
//        
//        return false
//    }
//    
//    
//    func haveRightTableViewInColumn(column: Int) -> Bool {
//        
//        return true
//    }
//    
//    func widthRatioOfLeftColumn(column: Int) -> CGFloat {
//        return 0.5
//    }
//    
//    func currentLeftSelectedRow(column: Int) -> Int {
//        
//        if(column == 0){
//        
//            return currentData1Index
//        }else{
//        
//            return currentData2Index
//        }
//        
//    }
//    
//    func menu(menu: JSDropDownMenu!, numberOfRowsInColumn column: Int, leftOrRight: Int, leftRow: Int) -> Int {
//        
//        if (column == 0) {
//            
//            return self.findData1.count
//        }else{
//        
//            return self.findData2.count
//        
//        }
//        
//    }
//    
//    func menu(menu: JSDropDownMenu!, titleForColumn column: Int) -> String! {
//        
//        if (column == 0) {
//            
//            
//            let dic = self.findData1[0] as! NSDictionary
//            let name = dic.allKeys.first as! String
//            return name
//
//            
//        }else{
//        
//            let model = self.findData2[0]
//            return model.text
//
//        
//        }
//        
//    }
//    
//    func menu(menu: JSDropDownMenu!, titleForRowAtIndexPath indexPath: JSIndexPath!) -> String! {
//        
//        if (indexPath.column==0) {
//            if (indexPath.leftOrRight==0) {
//                
//                return "1"
//                
//            } else{
//                
//                return "1"
//
//            }
//        } else {
//            
//            if (indexPath.leftOrRight==0) {
//               
//                return "1"
//
//            } else{
//                
//                return "1"
//
//               
//            }
//        }
//        
//    }
    
    
    
    
//    // MARK:右键点击事件
//    func menuReloadData() {
//      
//    }
//    // MARK:按钮事件
//    func selectIndexPathAction(sender: AnyObject) {
//        self.menu.selectIndexPath(YXJIndexPath(col: 0, row: 2, item: 2))
//    }
//    
//    // MARK:YXJDropDownMenuDelegate
//    func numberOfColumnsInMenu(menu: YXJDropDownMenu!) -> Int {
//        
//        return 2
//    }
//    func menu(menu: YXJDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
//        
//        if (column == 0) {
//            return self.findData1.count
//        } else {
//            return self.findData2.count
//        }
//    }
//    
//    
//    
//    func menu(menu: YXJDropDownMenu!, configRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
//        if (indexPath.column == 0) {
//            
//            let dic = self.findData1[indexPath.row] as! NSDictionary
//            let name = dic.allKeys.first as! String
//            let cellData = YXJCellData(title: name, detailText: "", defaultImage: UIImage(named: ""), selectImage: UIImage(named: ""))
//            return cellData
//            
//        } else {
//            
//            let model = self.findData2[indexPath.row]
//           
//            let cellData = YXJCellData(title: model.text, detailText: "", defaultImage: UIImage(named: ""), selectImage: UIImage(named: ""))
//            
//            return cellData
//        }
//    }
//    func menu(menu: YXJDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
//        
//        
//        if (column == 0) {
//            
//            let dic = self.findData1[row] as! NSDictionary
//            let name = dic.allKeys.first as! String
//            let array1 = dic.objectForKey(name) as! [String]
//            return array1.count
//        
//        }else{
//            
//            let model = self.findData2[row]
//            let array = model.children
//            if (array == nil){
//            
//                return 0
//            }
//            return array!.count
//
//        }
//    }
//    func menu(menu: YXJDropDownMenu!, configItemsInRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
//        if (indexPath.column == 0) {
//           
//            let dic = self.findData1[indexPath.row] as! NSDictionary
//            let name = dic.allKeys.first as! String
//            let array1 = dic.objectForKey(name) as! [String]
//            let cellData = YXJCellData(title: array1[indexPath.item], detailText: "", defaultImage: UIImage(named: ""), selectImage: UIImage(named: ""))
//            return cellData
//            
//        }else{
//        
//            print(indexPath.row)
//            let model = self.findData2[indexPath.row]
//            print(indexPath.item)
//            let city = model.children![indexPath.item]
//            let cellData = YXJCellData(title: city.text, detailText: "", defaultImage: UIImage(named: ""), selectImage: UIImage(named: ""))
//            return cellData
//        }
//    }
//    func menu(menu: YXJDropDownMenu!, didSelectRowAtIndexPath indexPath: YXJIndexPath!) {
//       
//        print(indexPath.column)
//        print(indexPath.row)
//        print(indexPath.item)
//    }
//
    
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! LXFindCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        }else{
        
            cell.backgroundColor = UIColor.lxcolorWithHexString("#e3d9c0")
            
        }
        cell.model = self.dataList[indexPath.row]
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(HHViewController.btnClick(_:)), forControlEvents: .TouchUpInside)
        
        return cell
        
        
    }
    
    func btnClick(sender:UIButton){
    
        
        let model = self.dataList[sender.tag]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
                
        return 110
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = self.dataList[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
}















