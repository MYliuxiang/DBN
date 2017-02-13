//
//  security security security SecurityVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class SecurityVC: YMBaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let names = ["手机号码","登录密码"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "账户安全"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
           
            let label = UILabel()
            label.frame = CGRectMake(kScreenWidth - 40 - 200, 8, 200, 24)
            label.textAlignment = .Right
            label.textColor = UIColor.lxcolorWithHexString("#666666")
            label.tag = 100
            cell?.contentView.addSubview(label)
        }
        
        cell?.textLabel?.text=names[indexPath.row];
        let label = cell?.contentView.viewWithTag(100) as! UILabel

        if indexPath.row == 0 {
            
            cell?.accessoryType = UITableViewCellAccessoryType.None
            label.text = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? String
        }else{
            
            cell?.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
            label.text = "修改"
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
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 1 {
            navigationController?.pushViewController(FixPassVC(), animated: true)
        }
    }
   

}
