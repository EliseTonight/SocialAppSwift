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

    
    fileprivate var sectionArray:NSMutableArray = NSMutableArray()
    fileprivate var sectionTitlesArray:NSMutableArray = NSMutableArray()
    
    fileprivate lazy var anotherVC:AnotherInfoViewController? = {
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
    fileprivate var isAbleHasData = true
    var model:ContactModels? {
        didSet {
        }
    }
    
    
    fileprivate var mainTableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 108))
    
    fileprivate func getData(_ num:Int) {
        self.model = ContactModels()
        self.model?.initMemberWithNum(num)
        self.createList()
        self.mainTableView.reloadData()
    }
    
    fileprivate func createList() {
        //create a temp sectionArray
        let collation = UILocalizedIndexedCollation.current()
        let numberOfSections = collation.sectionTitles.count
        let newSectionArray = NSMutableArray()
        for _ in 0..<numberOfSections {
            newSectionArray.add(NSMutableArray())
        }
        // insert Persons info into newSectionArray
        for modelIn in (self.model?.contacts)! {
            let sectionIndex = collation.section(for: modelIn, collationStringSelector: Selector("getName"))
            (newSectionArray[sectionIndex] as AnyObject).add(modelIn)
        }
//        print(newSectionArray)
        //sort the person of each section
        for index in 0..<numberOfSections {
            let personsForSection = newSectionArray[index]
            let sortedPersonsForSection = collation.sortedArray(from: personsForSection as! [AnyObject], collationStringSelector: Selector(("getName")))
            newSectionArray[index] = sortedPersonsForSection as! [ContactModel]
        }
        let temp = NSMutableArray()
        self.sectionTitlesArray = NSMutableArray()
        newSectionArray.enumerateObjects ({ (arr, idx, stop) in
            if (arr as AnyObject).count == 0 {
                temp.add(arr)
            }
            else {
                self.sectionTitlesArray.add(collation.sectionTitles[idx])
            }
        })
        
        newSectionArray.removeObjects(in: temp as [AnyObject])
        let operrationModels:NSMutableArray = NSMutableArray()
        for i in 0...1 {
            if i == 0 {
                let modelM = ContactModel()
                modelM.name = "新的朋友"
                modelM.image = "shortcut_addFri"
                operrationModels.add(modelM)
            }
            else {
                let modelM = ContactModel()
                modelM.name = "群聊"
                modelM.image = "shortcut_multichat"
                operrationModels.add(modelM)
            }
        }
        newSectionArray.insert(operrationModels, at: 0)
        self.sectionTitlesArray.insert("", at: 0)
        self.sectionArray = newSectionArray
    }
    fileprivate var whiteView = UIView(frame: CGRect(x: 0, y: -100, width: AppWidth, height: 100))
    fileprivate func setTableView() {
        self.title = "通讯录"
        self.view.addSubview(mainTableView)
        whiteView.backgroundColor = UIColor.white
        self.view.addSubview(whiteView)
        self.mainTableView.separatorStyle = .none
        self.mainTableView.sectionIndexBackgroundColor = UIColor.clear
        self.mainTableView.sectionIndexColor = UIColor.lightGray
        self.mainTableView.backgroundColor = UIColor.white
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.mainTableView.rowHeight = 50
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
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
    fileprivate var defaultView = DefaultView.defaultViewFromXib()
    fileprivate func setDefaultView() {
        weak var selfRef = self
        self.defaultView.delegate = selfRef
        self.view.addSubview(defaultView)
        self.defaultView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight)
    }  //设置左侧与右侧
    fileprivate func setNavigationItem(_ imageName:String,enable:Bool) {
        //左侧
        let imageView = CornerImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        imageView.image = UIImage(named: imageName)
        imageView.cornerRadius = 18
        let tap = UITapGestureRecognizer(target: self, action: #selector(DescoverViewController.leftButtonClick))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        self.navigationItem.leftBarButtonItem?.isEnabled = enable
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: CornerImageView(image: UIImage(named: "head")), style: UIBarButtonItemStyle.Plain, target: self, action: "leftButtonClick")
    }
    @objc fileprivate func leftButtonClick() {
        self.tabBarController?.selectedIndex = 3
    }

    //MARK: - 登录信息判断模块
    fileprivate func loginInfoJudge() {
        if UserPhone == nil {
            self.defaultView.isHidden = false
            self.setNavigationItem("logo_s", enable: false)
        }
        else if UserPhone == "15112345678"{
            self.defaultView.isHidden = true
            self.isAbleHasData = true
            self.setNavigationItem("head", enable: true)
        }
        else {
            self.defaultView.isHidden = true
            self.isAbleHasData = false
            self.setNavigationItem("logo_s", enable: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginInfoJudge()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.sectionArray[section].count)
        return (self.sectionArray[section] as AnyObject).count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitlesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: ContactCellId)
        if cell == nil {
            cell = ContactCell(style: .default, reuseIdentifier: ContactCellId)
        }
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row
        let smodel = self.sectionArray[section] as! NSArray
        let finalModel = smodel[row]
        (cell as! ContactCell).model = finalModel as? ContactModel
        return cell!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitlesArray.object(at: section) as? String
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionTitlesArray as! [String]
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 100
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = (indexPath as NSIndexPath).section
        if section != 0 && section != 1 {
            let row = (indexPath as NSIndexPath).row
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
