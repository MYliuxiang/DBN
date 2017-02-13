//
//  ScanVC.swift
//  DBN
//
//  Created by Viatom on 16/10/8.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class ScanVC: YMBaseViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var leftView: UIView!
    
    var dataList:[ProductListModel] = []
    
    let tagNames = ["豌豆豌豆豌豆豌豆豌豆","豌豆豌豆","豌豆豌豆","豌豆豌豆豌豆豌豆豌豆","豌豆豌豆豌豆豌豆豌豆","豌豆","豌豆豌豆豌豆","豌豆豌豆豌豆豌豆豌豆","豌豆豌豆","豌豆豌豆豌豆豌豆豌豆","豌豆","豌豆","豌豆","豌豆","豌豆"]

    override func viewDidLoad() {
        super.viewDidLoad()

        text = "搜索"
        addrighttitleString("搜索")
        
        textField.leftViewMode = UITextFieldViewMode.Always
        textField.leftView = leftView
        
        textField.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true

         tableView.registerNib(UINib(nibName: "MyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cellID")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightAC() {
        loadData()
    }
    
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
//        let identifier="identtifier";
//        var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
//        if(cell == nil){
//            cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
//            cell?.selectionStyle = UITableViewCellSelectionStyle.None
//            cell?.backgroundColor = UIColor.clearColor()
//            let tagView = SKTagView()
//            tagView.tag = 100
//            cell?.contentView .addSubview(tagView)
//        }
//        
//        configCell(cell!, indexpath: indexPath)
//        return cell!;
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! MyCell
        
        cell.model = self.dataList[indexPath.row]
        
        return cell

        
    }
    
    func configCell(cell:UITableViewCell, indexpath:NSIndexPath){
    
        let tagView = cell.contentView.viewWithTag(100) as! SKTagView
        
        
        tagView.removeAllTags()
        tagView.preferredMaxLayoutWidth = kScreenWidth;
        tagView.padding = UIEdgeInsetsMake(10, 20, 10, 20);
        tagView.lineSpacing = 10;
        tagView.interitemSpacing = 10;
        tagView.singleLine = false;
        // 给出两个字段，如果给的是0，那么就是变化的,如果给的不是0，那么就是固定的
        tagView.regularWidth = 0;
        tagView.regularHeight = 0;
        
        for str in tagNames{
            
            var color:UIColor
            
            if indexpath.section == 0 {
                
                color = UIColor.lxcolorWithHexString("#5e7733")
                
            }else{
            
                color = UIColor.lxcolorWithHexString("#666666")

            }
            
            let tag = SKTag(text: str);
            
            tag.font = UIFont.systemFontOfSize(15);
            tag.textColor = color;
            tag.bgColor = UIColor.whiteColor();
            tag.borderColor = color
            tag.borderWidth = 0.5
            tag.enable = true;
            tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
            tagView.addTag(tag)
            
            tagView.didTapTagAtIndex = {
                (index) -> () in
                print(index);
                
            }

            
        }
        
        let tagHeight = tagView.intrinsicContentSize().height
        tagView.frame = CGRectMake(0, 0, kScreenWidth, tagHeight);
        tagView.layoutSubviews()
        
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
        let model = self.dataList[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    //UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        loadData()
        
        return true
    }
    
    
    func loadData(){
    
        let  mobile = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? NSString
        var params:[String : AnyObject]
        
        if (mobile == nil) {
            
            params = ["Type":"QueryProductList","Mobile":"","Match":textField.text!]
            
        }else{
            
            params = ["Type":"QueryProductList","Mobile":mobile!,"Match":textField.text!]
            
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
                    
                        SVProgressHUD.showErrorWithStatus("暂无数据")

                    
                    }
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
        
        
    }
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
////        if section == 0 {
////            
////            let view = UIView()
////            view.frame = CGRectMake(0, 0, kScreenWidth, 30)
////            let label = UILabel()
////            label.frame = CGRectMake(10, 0, kScreenWidth, 30)
////            label.text = "热门搜索"
////            label.textColor = UIColor.lxcolorWithHexString("#fe7b02")
////            label.font = UIFont.systemFontOfSize(15)
////            view.addSubview(label)
////            return view
////            
////            
////            
////        }else{
////        
////            let view = UIView()
////            view.frame = CGRectMake(0, 0, kScreenWidth, 30)
////            let label = UILabel()
////            label.frame = CGRectMake(10, 0, kScreenWidth, 30)
////            label.text = "历史搜索"
////            label.textColor = UIColor.lxcolorWithHexString("#666666")
////            label.font = UIFont.systemFontOfSize(15)
////            view.addSubview(label)
////            return view
////
////        }
//        
//    }
    

 }










