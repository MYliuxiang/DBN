//
//  MeVC.swift
//  DBN
//
//  Created by Viatom on 16/9/23.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class MeVC: YMBaseViewController ,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var footjiLabel: UILabel!
    
    var imageNames = [["我的-联系客服","我的-留言"],["我的-设置","我的-关于我们"]]
    var names = [["联系客服","留言"],["设置","关于我们"]]

    @IBAction func loginAC(sender: AnyObject) {
        
        
        if NSUserDefaults.standardUserDefaults().boolForKey(Login) == false{
            let vc = LoginVC()
            let navVC = YMNavigationController(rootViewController:vc)
            presentViewController(navVC, animated: true, completion: nil)
        }

        
    }
    
    
    @IBAction func avatorClick(sender: AnyObject) {
        
        print("头像")

    }
    @IBAction func tap(sender: AnyObject) {
        
        print("收藏")
        let vc = MyCollectionVC()
        vc.iscollection = true
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    @IBAction func tap1(sender: AnyObject) {
        print("足迹")
        
        let vc = MyCollectionVC()
        vc.iscollection = false
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBOutlet weak var phoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        text = "我的"
        nav?.hidden = true
        self.automaticallyAdjustsScrollViewInsets = false;
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default;
        let rect = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 375 * 225)
        headerView.frame = rect
        tableView.tableHeaderView = headerView
        
        
       
        
   }

    
    func findUser(){
        
        let phone = NSUserDefaults.standardUserDefaults().objectForKey(Mobile)
        let params:[String : AnyObject] = ["Type":"getClient","Mobile":phone!]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                print(result)
                if (result!["State"] as! String == "True") {
                    print(result!["HeadImage"])
                    //成功
                    
                    let dic = result!["Client"] as! NSDictionary
                    
                    
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setBool(true, forKey: Login)
                    let imageUrl = dic["HeadImage"]  as? String
                    if (imageUrl != nil){
                        
                        userDefaults.setObject(dic["HeadImage"] , forKey: HeadImage)
                        
                    }
                    
                    let name = dic["Name_"]  as? String
                    
                    if (name != nil){
                        
                        userDefaults.setObject(dic["Name_"] , forKey: Name)
                        
                    }
                    
                    let sexstr = dic["Sex"]  as? String
                    if (sexstr != nil){
                        
                        userDefaults.setObject(dic["Sex"] , forKey: Sex)
                        
                    }
                    
                    let DeviceIDstr = dic["DeviceID"]  as? String
                    if (DeviceIDstr != nil){
                        
                        userDefaults.setObject(dic["DeviceID"] , forKey: DeviceID)
                        
                    }
                    
                    let IDstr = dic["ID"]  as? String
                    if (IDstr != nil){
                        
                        userDefaults.setObject(dic["ID"] , forKey: UserID)
                        
                    }
                    
                    let Mobileid = dic["Mobile"]  as? String
                    if (Mobileid != nil){
                        
                        userDefaults.setObject(dic["Mobile"] , forKey: Mobile)
                        
                    }
                    
                    let favoritesCount = dic["FavoritesCount"]  as? NSNumber
                    if (favoritesCount != nil){
                        
                        userDefaults.setObject(favoritesCount?.stringValue , forKey: FavoritesCount)
                        
                    }
                    
                    
                    let viewCount = dic["ViewCount"]  as? NSNumber
                    if (viewCount != nil){
                        
                        userDefaults.setObject(viewCount?.stringValue , forKey: ViewCount)
                        
                    }
                    
                    userDefaults.synchronize()
                    
//                    self?.footjiLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(ViewCount) as? String
//                    self?.collectionLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(FavoritesCount) as? String
                    
                }else{
                    //失败
                    SVProgressHUD.showErrorWithStatus(result!["Message"] as! String)
                    
                }
            }
            
        }

        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated.boolValue)
        
        let urlString = NSUserDefaults.standardUserDefaults().objectForKey(HeadImage)
        if urlString != nil {
            
            let url = NSURL(string:urlString! as! String )
            avatorImageView.sd_setImageWithURL(url)
        }
        
        phoneLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? String
        print(NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as? String)
        nameLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(Name) as? String
        
        if NSUserDefaults.standardUserDefaults().boolForKey(Login) == false{
           
            nameLabel.text = "请点击登录"
            
        }
        
//        footjiLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(ViewCount) as? String
//        collectionLabel.text = NSUserDefaults.standardUserDefaults().objectForKey(FavoritesCount) as? String
        
        if NSUserDefaults.standardUserDefaults().boolForKey(Login) == true{
            
//            findUser()
            
        }
        
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
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCellWithIdentifier(identifier);
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier);
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            if indexPath.section == 0 && indexPath.row == 0 {
                let imageValue = UIImageView()
                imageValue.frame = CGRectMake(kScreenWidth - 20 - 24, 8, 24, 24)
                imageValue.image = UIImage(named: "我的-拨号")
                cell?.contentView.addSubview(imageValue)
            }
        }
        
        cell?.textLabel?.text=names[indexPath.section][indexPath.row];
        cell?.imageView?.image = UIImage(named: imageNames[indexPath.section][indexPath.row])
        if indexPath.section == 0 && indexPath.row == 0 {
            
        cell?.accessoryType=UITableViewCellAccessoryType.None;

        }else{
            
        cell?.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
            
        }
        
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                print("拨打电话")
                let alert = UIAlertView()
                alert.title = "提示"
                alert.message = "是否拨打电话4007-888-015！"
                alert.addButtonWithTitle("取消")
                alert.addButtonWithTitle("确定")
                alert.delegate = self
                alert.show()
                
            }else{
            
                
                if NSUserDefaults.standardUserDefaults().boolForKey(Login) == false{
                    let vc = LoginVC()
                    let navVC = YMNavigationController(rootViewController:vc)
                    presentViewController(navVC, animated: true, completion: nil)
                }else{

                
                print("留言")
                navigationController?.pushViewController(LeaveMessageVC(), animated: true)
                    
                }

            }
        }else{
        
            if indexPath.row == 0 {
                
                if NSUserDefaults.standardUserDefaults().boolForKey(Login) == false{
                    let vc = LoginVC()
                    let navVC = YMNavigationController(rootViewController:vc)
                    presentViewController(navVC, animated: true, completion: nil)
                }else{

                print("设置")
                navigationController?.pushViewController(SetUpVC(), animated: true)
                    
                }

            }else{
                
                print("关于我们")
                navigationController?.pushViewController(AboutusVC(), animated: true)

            }
        
        }

    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if(buttonIndex==1){
            
            UIApplication.sharedApplication().openURL(NSURL(string :"tel://4007-888-015")!)

        }
    }
    
  

}

















