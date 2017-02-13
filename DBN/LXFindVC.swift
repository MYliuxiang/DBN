//
//  LXFindVC.swift
//  DBN
//
//  Created by 刘翔 on 16/10/20.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class LXFindVC: YMBaseViewController,YXJDropDownMenuDelegate, YXJDropDownMenuDataSource {

    @IBOutlet weak var findMenu: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var classifys = [YXJCellData]()
    var cates = [YXJCellData]()
    var movices = [YXJCellData]()
    var hostels = [YXJCellData]()
    var areas = [YXJCellData]()
    var sorts = [YXJCellData]()
    
    var dataList:[ProductListModel] = []

    
    lazy var menu = YXJDropDownMenu.init(origin: CGPointMake(0, 0), andHeight: 40)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classifys.append(YXJCellData(title: "全部", detailText: "", defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))
        classifys.append(YXJCellData(title: "今日新单", detailText: "0", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "0", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "0", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        
        cates.append(YXJCellData(title: "自助餐", detailText: "0", defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        cates.append(YXJCellData(title: "快餐", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        cates.append(YXJCellData(title: "火锅", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        cates.append(YXJCellData(title: "日韩料理", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        cates.append(YXJCellData(title: "西餐", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        cates.append(YXJCellData(title: "烧烤小吃", detailText: "6", defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))
        
        movices.append(YXJCellData(title: "内地剧", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        movices.append(YXJCellData(title: "港台剧", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        movices.append(YXJCellData(title: "英美剧", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        
        hostels.append(YXJCellData(title: "经济酒店", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        hostels.append(YXJCellData(title: "商务酒店", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        hostels.append(YXJCellData(title: "连锁酒店", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        hostels.append(YXJCellData(title: "度假酒店", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        hostels.append(YXJCellData(title: "公寓酒店", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        
        areas.append(YXJCellData(title: "全部", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        areas.append(YXJCellData(title: "芙蓉区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        areas.append(YXJCellData(title: "雨花区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        areas.append(YXJCellData(title: "天心区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        areas.append(YXJCellData(title: "开福区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        areas.append(YXJCellData(title: "岳麓区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))
        
        sorts.append(YXJCellData(title: "默认排序", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "离我最近", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "好评优先", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "人气优先", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "最新发布", detailText: nil, defaultImage: nil, selectImage: nil))
        
        // 添加下拉菜单
        self.menu.delegate = self
        self.menu.dataSource = self
        self.menu.textColor = UIColor.lxcolorWithHexString("#333333")
        self.menu.textSelectedColor = LXColor(88, g: 158, b: 59, a: 1)
        self.menu.backgroundColor = LXColor(228, g: 228, b: 228, a: 1)
        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu.selectDefalutIndexPath()
        self.findMenu.addSubview(menu)    
        
        
        tableView.registerNib(UINib(nibName: "MyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cellID")
        

    }
    
    
    //YjDelegate
    // MARK:右键点击事件
    func menuReloadData() {
        self.classifys.removeAll()
        classifys.append(YXJCellData(title: "今日新单", detailText: "2", defaultImage: UIImage(named: "1"), selectImage: UIImage(named: "1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "3", defaultImage: UIImage(named: "2"), selectImage: UIImage(named: "2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "4", defaultImage: UIImage(named: "3"), selectImage: UIImage(named: "3_select")))
        self.menu.reloadData()
    }
    // MARK:按钮事件
    func selectIndexPathAction(sender: AnyObject) {
        self.menu.selectIndexPath(YXJIndexPath(col: 0, row: 2, item: 2))
    }
    
    // MARK:YXJDropDownMenuDelegate
    func numberOfColumnsInMenu(menu: YXJDropDownMenu!) -> Int {
        return 3
    }
    func menu(menu: YXJDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        if (column == 0) {
            return self.classifys.count
        } else if (column == 1) {
            return self.areas.count
        } else {
            return self.sorts.count
        }
    }
    func menu(menu: YXJDropDownMenu!, configRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
        if (indexPath.column == 0) {
            return self.classifys[indexPath.row]
        } else if (indexPath.column == 1) {
            return self.areas[indexPath.row]
        } else {
            return self.sorts[indexPath.row]
        }
    }
    func menu(menu: YXJDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
        if (column == 0) {
            if (row == 0) {
                return self.cates.count
            } else if (row == 2) {
                return self.movices.count
            } else if (row == 3) {
                return self.hostels.count
            }
        }
        return 0
    }
    func menu(menu: YXJDropDownMenu!, configItemsInRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
        if (indexPath.column == 0) {
            if (indexPath.row == 0) {
                return cates[indexPath.item]
            } else if (indexPath.row == 2) {
                return movices[indexPath.item]
            } else if (indexPath.row == 3) {
                return hostels[indexPath.item]
            }
            
        }
        return nil
    }
    func menu(menu: YXJDropDownMenu!, didSelectRowAtIndexPath indexPath: YXJIndexPath!) {
        if (indexPath.item >= 0) {
            print("点击了 \(indexPath.column) - \(indexPath.row) - indexPath.item 项目")
        } else {
            print("点击了 \(indexPath.column) - \(indexPath.row) 项目")
        }
    }
    
    
    
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! MyCell
        
        cell.model = self.dataList[indexPath.row]
        
        return cell
        
        
    }
    
       
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        
        return UITableViewCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

























