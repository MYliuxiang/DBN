//
//  SetUpVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class SetUpVC: YMBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var button: UIButton!
    @IBOutlet var footView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var names = [["个人信息","账户安全"],["清空缓存"]]

    @IBAction func signOutAC(sender: AnyObject) {
        
        print("退出登陆")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.removeObjectForKey(DeviceID)
        userDefaults.removeObjectForKey(HeadImage)
        userDefaults.removeObjectForKey(Name)
        userDefaults.removeObjectForKey(Sex)
        userDefaults.removeObjectForKey(Mobile)
        userDefaults.removeObjectForKey(UserID)
        userDefaults.removeObjectForKey(Login)

        userDefaults.synchronize()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text = "设置"
        // Do any additional setup after loading the view.
        footView.frame = CGRectMake(0, 0, kScreenWidth, 240)
        tableView.tableFooterView = footView
        
        button.layer.borderColor = UIColor.lxcolorWithHexString("#dddddd").CGColor
        button.layer.borderWidth = 1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            if indexPath.section == 1 && indexPath.row == 0 {
                let label = UILabel()
                label.frame = CGRectMake(kScreenWidth - 35 - 200, 8, 200, 24)
                label.textAlignment = .Right
                label.textColor = UIColor.lxcolorWithHexString("#666666")
                label.tag = 100
                cell?.contentView.addSubview(label)
            }
        }
        
        let label = cell?.contentView.viewWithTag(100) as? UILabel
        
        let tmpSize = Float(SDImageCache.sharedImageCache().getDiskCount())
        label?.text = String(format: "%.2fM",tmpSize / 1000 / 1000.0)
        cell?.textLabel?.text=names[indexPath.section][indexPath.row];
        cell?.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
        
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
            
                print("个人信息")
                navigationController?.pushViewController(PersonalVC(), animated: true)
            }else{
                
                print("账户安全")
                navigationController?.pushViewController(SecurityVC(), animated: true)
            
            }
        }else{
        
            print("清楚缓存")
            SDImageCache.sharedImageCache().cleanDisk()
            tableView.reloadData()

        
        }
    }

}




