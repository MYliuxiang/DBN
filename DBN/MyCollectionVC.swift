//
//  MyCollectionVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class MyCollectionVC: YMBaseViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    var iscollection = Bool?()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if iscollection == true {
            
            text = "我的收藏"
            
        }else{
        
            text = "我的足迹"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MyCell
        
        if(cell == nil){
            
            cell=NSBundle.mainBundle().loadNibNamed("MyCell", owner: nil, options: nil)!.first as? MyCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            
        }
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MyCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    
}
