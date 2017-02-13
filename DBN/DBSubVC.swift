//
//  DBSubVC.swift
//  DBN
//
//  Created by Viatom on 16/10/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class DBSubVC: YMBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var year:String!
    var dataArray:[ProductListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nav?.hidden = true
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "MyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "cellid")

        loadData()
        
        
    }
    
    func loadData(){
    
        let params:[String : AnyObject] = ["Type":"QueryProductList","Mobile":"","RegYear":year]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                print(params)
                if (result!["State"] as! String == "True") {
                    
                    let array = result!["ProductList"] as! NSArray
                    if(array.count != 0){
                    let modelTool = DictModelManager.sharedManager
                    self?.dataArray = modelTool.objectsWithArray(array, cls: ProductListModel.self) as! [ProductListModel]
                    self?.tableView.reloadData()
                    }
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }
        
        
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
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellid") as! MyCell
        
        cell.model = self.dataArray[indexPath.row]
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        navigationController?.pushViewController(DBDetailVC(), animated: true)
        let model = self.dataArray[indexPath.row]
        let vc = DBDetailVC()
        vc.id = model.ID!
        navigationController?.pushViewController(vc, animated: true)

    }

   
}
