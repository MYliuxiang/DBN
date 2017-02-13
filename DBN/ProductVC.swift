//
//  ProductVC.swift
//  DBN
//
//  Created by Viatom on 16/9/23.
//  Copyright © 2016年 刘翔. All rights reserved.
//

import UIKit

private let columnCellID = "columnCell"
private let cellID = "SingleGifCell"
private let sectionID = "SingleGifSectionView"


class ProductVC: YMBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    private var selectedColumnRow = 0

    @IBOutlet weak var lxlayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataList:[AnyObject] = []
    var dataList1:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        text = "分类"
        addImageString("标题栏-查找")
        tableView.registerNib(UINib(nibName: "SingleGifColumnCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: columnCellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10)
        collectionView.registerNib(UINib(nibName: "SingleGifCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.registerNib(UINib(nibName: "SingleGifSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID)
//        let section = NSBundle.mainBundle().loadNibNamed("SingleGifSectionView", owner: self, options: nil).last!
        lxlayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 100)
        lxlayout.minimumInteritemSpacing = 10
        lxlayout.minimumLineSpacing = 10
        lxlayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        loadData()
        
        

    }

    
    func loadData(){
    
        let params:[String : AnyObject] = ["Type":"QueryKind"]
        
        LXDataTool.getData("url",params,isHUD: true){ [weak self](result) in
            
            if result != nil {
                
                print(result)
                if (result!["State"] as! String == "True") {
                    
                    let array = result!["Kinds"] as! NSArray


                    if(array.count != 0){
                    
                        self?.dataList = array as [AnyObject]
                        
                        let dic = self?.dataList[0] as! NSDictionary
                        let name = dic.allKeys.first as! String
                        let array1 = dic.objectForKey(name) as! [String]
                        self?.dataList1 = array1
                        self?.tableView.reloadData()
                        self?.collectionView.reloadData()
                        
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
    

    override func rightAC() -> () {
        
        navigationController?.pushViewController(ScanVC(), animated: true)
        
    }
    
    //mark tableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
               return self.dataList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(columnCellID) as! SingleGifColumnCell
        cell.changeStatus(indexPath.row == selectedColumnRow ? true : false)
        
        
        let dic = self.dataList[indexPath.row] as! NSDictionary
        let name = dic.allKeys.first as! String
        cell.titleBtn.setTitle(name, forState: .Normal)
        
        
        
        
        return cell
        
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
        selectedColumnRow = indexPath.row
        tableView.reloadData()
        
        let dic = self.dataList[indexPath.row] as! NSDictionary
        let name = dic.allKeys.first as! String
        let array1 = dic.objectForKey(name) as! [String]
        self.dataList1 = array1
        self.collectionView.reloadData()

    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList1.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SingleGifCell
        
        
        cell.label.text = self.dataList1[indexPath.row] as? String
        print(self.dataList1[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: sectionID, forIndexPath: indexPath) as! SingleGifSectionView
        return sectionView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let VC = HHViewController()
        let sindextPath = DOPIndexPath(col: 0,row: selectedColumnRow,item: indexPath.item)
        VC.seletcedIndex = sindextPath
        navigationController?.pushViewController(VC, animated: true)
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSize(width:(kScreenWidth / 4.0 * 3.0 - 40) / 3.0 - 1, height: 50)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//       
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//      
//        return CGSizeMake(kScreenWidth / 4 * 3, 110 * ratioWidth + 10)
//    }

    
    

}

/// 分组头部
class SingleGifSectionView: UICollectionReusableView {
    
}





