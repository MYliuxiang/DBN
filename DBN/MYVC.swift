//
//  MYVC.swift
//  DBN
//
//  Created by 刘翔 on 16/10/19.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class MYVC: YMBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArray = [ProductListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "名优地标"
        addImageString("标题栏-查找")

        
        // Do any additional setup after loading the view.
    }

    override func rightAC() {
        
        navigationController?.pushViewController(ScanVC(), animated: true)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MyCell
        if(cell == nil){
            
            cell=NSBundle.mainBundle().loadNibNamed("MyCell", owner: nil, options: nil)!.first as? MyCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            
        }
        
         cell?.model = dataArray[indexPath.row]
        
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
        
        let model = self.dataArray[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)
        
        
    }


}

















