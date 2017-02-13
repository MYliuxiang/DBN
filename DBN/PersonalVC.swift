//
//  PersonalVC.swift
//  DBN
//
//  Created by Viatom on 16/9/29.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

class PersonalVC: YMBaseViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let names = ["头像","昵称"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        text = "个人信息"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
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
            
                let imageValue = UIImageView()
                imageValue.frame = CGRectMake(kScreenWidth - 40 - 24, 13, 24, 24)
                imageValue.layer.cornerRadius = 12
                imageValue.layer.masksToBounds = true
                imageValue.tag = 99
                cell?.contentView.addSubview(imageValue)
                
            
                let label = UILabel()
                label.frame = CGRectMake(kScreenWidth - 40 - 200, 13, 200, 24)
                label.textAlignment = .Right
                label.textColor = UIColor.lxcolorWithHexString("#666666")
                label.tag = 100
                label.font = UIFont.systemFontOfSize(12)
                cell?.contentView.addSubview(label)
            
        }
        
        
        let auatorimage = cell?.contentView.viewWithTag(99) as! UIImageView
        let label = cell?.contentView.viewWithTag(100) as! UILabel
        
        label.text = NSUserDefaults.standardUserDefaults().objectForKey(Name) as? String
        auatorimage.image = UIImage(named: "我的-头像")
        if indexPath.row == 0 {
            label.hidden = true
            auatorimage.hidden = false
        }else{
            label.hidden = false
            auatorimage.hidden = true
            
        }
        cell?.textLabel?.text=names[indexPath.row];
        cell?.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
        
        return cell!;
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            
//            print("修改头像")
//            var sheet:UIActionSheet
//            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
//                sheet = UIActionSheet()
//                sheet.title = "选择"
//                sheet.delegate = self
//               sheet.cancelButtonIndex = 2
//                sheet.addButtonWithTitle("从相册中选择")
//                sheet.addButtonWithTitle("拍照")
//                sheet.addButtonWithTitle("取消")
//
//            }else{
//                sheet = UIActionSheet()
//                sheet.title = "选择"
//                sheet.delegate = self
//                sheet.cancelButtonIndex = 1
//                sheet.addButtonWithTitle("从相册中选择")
//                sheet.addButtonWithTitle("取消")
//            }
//            sheet.tag = 255
//            sheet.showInView(self.view)
            
            
        }else{
        
            print("修改昵称")
            
            navigationController?.pushViewController(FixNickNameVC(), animated: true)
            
        }
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
            var soureceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                switch(buttonIndex)
                {
                case 2://取消
                    return
                case 1://相机
                    soureceType = UIImagePickerControllerSourceType.Camera
                    break
                case 0: //相册
                    soureceType = UIImagePickerControllerSourceType.PhotoLibrary
                    break
                default:
                    return
                }
            
            }else{
                if(buttonIndex == 1){
                    return
                }else{
                    soureceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                }
            
        }
            let imagePickerController:UIImagePickerController = UIImagePickerController()

        imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = soureceType
            self.presentViewController(imagePickerController, animated: true, completion: { () -> Void in
            })
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//        

//    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage

        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        let params = ["Type":"Configs","Mobile":NSUserDefaults.standardUserDefaults().objectForKey(Mobile) as! String]
//        LXDataTool.uploadImage(image,params, isHUD: true){
//            [weak self](result) in
//            print(result)
//        }
        
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

 
}


















