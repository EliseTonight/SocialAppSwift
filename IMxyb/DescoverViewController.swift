//
//  DescoverViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

public let ContactCellId = "ContactCell"
class DescoverViewController: UIViewController {

    
    private var sectionArray:NSMutableArray = NSMutableArray()
    private var sectionTitlesArray:NSMutableArray = NSMutableArray()
    
    private lazy var anotherVC:AnotherInfoViewController? = {
        let anotherVC = AnotherInfoViewController()
        return anotherVC
    }()
    
//    
//    //主要的tableview
//    private var mainTableView = UITableView()
//    
//    
//    private func setMainTableView() {
//        self.mainTableView
//    }
    private var isAbleHasData = true
    var model:ContactModels? {
        didSet {
        }
    }
    
    
    private var mainTableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 108))
    
    private func getData(num:Int) {
        self.model = ContactModels()
        self.model?.initMemberWithNum(num)
        self.createList()
        self.mainTableView.reloadData()
    }
    
    private func createList() {
        //create a temp sectionArray
        let collation = UILocalizedIndexedCollation.currentCollation()
        let numberOfSections = collation.sectionTitles.count
        let newSectionArray = NSMutableArray()
        for _ in 0..<numberOfSections {
            newSectionArray.addObject(NSMutableArray())
        }
        // insert Persons info into newSectionArray
        for modelIn in (self.model?.contacts)! {
            let sectionIndex = collation.sectionForObject(modelIn, collationStringSelector: "getName")
            newSectionArray[sectionIndex].addObject(modelIn)
        }
//        print(newSectionArray)
        //sort the person of each section
        for index in 0..<numberOfSections {
            let personsForSection = newSectionArray[index]
            let sortedPersonsForSection = collation.sortedArrayFromArray(personsForSection as! [AnyObject], collationStringSelector: "getName")
            newSectionArray[index] = sortedPersonsForSection as! [ContactModel]
        }
        let temp = NSMutableArray()
        self.sectionTitlesArray = NSMutableArray()
        newSectionArray.enumerateObjectsUsingBlock { (arr, idx, stop) -> Void in
            if arr.count == 0 {
                temp.addObject(arr)
            }
            else {
                self.sectionTitlesArray.addObject(collation.sectionTitles[idx])
            }
        }
        newSectionArray.removeObjectsInArray(temp as [AnyObject])
        let operrationModels:NSMutableArray = NSMutableArray()
        for i in 0...1 {
            if i == 0 {
                let modelM = ContactModel()
                modelM.name = "新的朋友"
                modelM.image = "shortcut_addFri"
                operrationModels.addObject(modelM)
            }
            else {
                let modelM = ContactModel()
                modelM.name = "群聊"
                modelM.image = "shortcut_multichat"
                operrationModels.addObject(modelM)
            }
        }
        newSectionArray.insertObject(operrationModels, atIndex: 0)
        self.sectionTitlesArray.insertObject("", atIndex: 0)
        self.sectionArray = newSectionArray
    }
    private var whiteView = UIView(frame: CGRect(x: 0, y: -100, width: AppWidth, height: 100))
    private func setTableView() {
        self.title = "通讯录"
        self.view.addSubview(mainTableView)
        whiteView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(whiteView)
        self.mainTableView.separatorStyle = .None
        self.mainTableView.sectionIndexBackgroundColor = UIColor.clearColor()
        self.mainTableView.sectionIndexColor = UIColor.lightGrayColor()
        self.mainTableView.backgroundColor = UIColor.whiteColor()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.rowHeight = 50
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setTableView()
        getData(30)
        
        setDefaultView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //覆盖的View
    private var defaultView = DefaultView.defaultViewFromXib()
    private func setDefaultView() {
        weak var selfRef = self
        self.defaultView.delegate = selfRef
        self.view.addSubview(defaultView)
        self.defaultView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight)
    }  //设置左侧与右侧
    private func setNavigationItem(imageName:String,enable:Bool) {
        //左侧
        let imageView = CornerImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        imageView.image = UIImage(named: imageName)
        imageView.cornerRadius = 18
        let tap = UITapGestureRecognizer(target: self, action: "leftButtonClick")
        imageView.addGestureRecognizer(tap)
        imageView.userInteractionEnabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        self.navigationItem.leftBarButtonItem?.enabled = enable
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: CornerImageView(image: UIImage(named: "head")), style: UIBarButtonItemStyle.Plain, target: self, action: "leftButtonClick")
    }
    @objc private func leftButtonClick() {
        self.tabBarController?.selectedIndex = 3
    }

    //MARK: - 登录信息判断模块
    private func loginInfoJudge() {
        if UserPhone == nil {
            self.defaultView.hidden = false
            self.setNavigationItem("logo_s", enable: false)
        }
        else if UserPhone == "15112345678"{
            self.defaultView.hidden = true
            self.isAbleHasData = true
            self.setNavigationItem("head", enable: true)
        }
        else {
            self.defaultView.hidden = true
            self.isAbleHasData = false
            self.setNavigationItem("logo_s", enable: true)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loginInfoJudge()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        loginInfoJudge()
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DescoverViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.sectionArray[section].count)
        return self.sectionArray[section].count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionTitlesArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCellWithIdentifier(ContactCellId)
        if cell == nil {
            cell = ContactCell(style: .Default, reuseIdentifier: ContactCellId)
        }
        let section = indexPath.section
        let row = indexPath.row
        let smodel = self.sectionArray[section] as! NSArray
        let finalModel = smodel[row]
        (cell as! ContactCell).model = finalModel as! ContactModel
        return cell!
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitlesArray.objectAtIndex(section) as! String
    }
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sectionTitlesArray as! [String]
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 100
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        if section != 0 && section != 1 {
            let row = indexPath.row
            let smodel = self.sectionArray[section] as! NSArray
            let finalModel = smodel[row] as! ContactModel
            let messageModel = MessageModel()
            messageModel.icon = finalModel.image
            messageModel.youName = finalModel.name
            self.anotherVC?.model = messageModel
            self.anotherVC?.isCreateMessageAble = false
            self.navigationController?.pushViewController(anotherVC!, animated: true)
        }
    }
}
//即默认界面的登录
extension DescoverViewController:DefaultViewDelegate {
    func defaultViewTapDelegate() {
        self.tabBarController?.selectedIndex = 3
    }
}