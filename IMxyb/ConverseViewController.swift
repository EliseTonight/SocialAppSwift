//
//  ConverseViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


public let ConversationCellId = "ConCell"
public let MessageChangeNotification = "MessageChangeNotification"

class ConverseViewController: UIViewController {

    convenience init(model:MessageModel) {
        self.init()
        self.model = model
    }
    
    fileprivate var finalHeight:CGFloat = 0
    //所有消息模型
    var model:MessageModel? {
        didSet {
            for i in 0..<(model?.message?.count ?? 0) {
                let singleModel = singleMessageModel()
                singleModel.icon = self.model?.icon
                singleModel.myicon = (self.model?.myicon)!
                singleModel.times = self.model?.times
                singleModel.youName = self.model?.youName
                let cellText = self.model?.message![i]
                let key = [String](cellText!.keys).first
                if key == "me" {
                    singleModel.type = 0
                }
                else if key == "other"{
                    singleModel.type = 1
                }
                singleModel.message = [String](cellText!.values).first
                self.multiModel.append(singleModel)
            }
        }
    }
    
    //分类模型
    var multiModel:[singleMessageModel] = [] {
        didSet {
            
//            if multiModel.count == model?.message?.count {
                self.mainTableView?.reloadData()
//            }
        }
    }
    
    
    //设置底部
    fileprivate var bottomView = WriteView.writeViewFromXib(CGRect(x: 0, y: AppHeight - 40, width: AppWidth, height: 40))
    fileprivate func setBottom() {
        weak var selfRef = self
        bottomView.alpha = 1.0
        bottomView.delegate = selfRef
        self.view.addSubview(bottomView)
        NotificationCenter.default.addObserver(self, selector: #selector(ConverseViewController.keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    //编辑开始与编辑结束，变化view的位置，添加监听器
    @objc fileprivate func keyboardWillChangeFrame(_ notify:Notification) {
        let info = (notify as NSNotification).userInfo
        let durationTime:Double = info![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardEndFrame:CGRect = (info![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let getMinY = keyboardEndFrame.minY
//        self.keyboardBackView?.hidden = !self.keyboardBackView!.hidden
        UIView.animate(withDuration: durationTime, animations: { () -> Void in
            //变化tableView的包含位置与键盘的
            self.bottomView.frame = CGRect(x: 0, y: getMinY - 40, width: AppWidth, height: 40)
            let currentMaxY = (self.mainTableView?.contentOffset.y)!
            let minY = self.bottomView.frame.minY
//            self.mainTableView?.setContentOffset(CGPoint(x: 0, y: currentMaxY + lineY), animated: true)
        }) 
    }
//    //收回keyboard的背景覆盖view
//    private lazy var keyboardBackView:UIView? = {
//        let view = UIView(frame: AppSize)
//        view.backgroundColor = UIColor.whiteColor()
//        view.alpha = 0.0
//        let tap = UITapGestureRecognizer(target: self, action: "cancelEdit")
//        view.userInteractionEnabled = true
//        view.addGestureRecognizer(tap)
//        view.hidden = true
//        return view
//    }()
    fileprivate func setCancelEdit() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConverseViewController.cancelEdit))
        self.mainTableView?.addGestureRecognizer(tap)
        self.mainTableView?.isUserInteractionEnabled = true
    }
    @objc fileprivate func cancelEdit() {
        self.view.endEditing(true)
    }

    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight - 40), style: UITableViewStyle.plain)
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor.white
        return mainTableView
    }()
    
    fileprivate func setMainTableView() {
        self.mainTableView?.delegate = self
        self.mainTableView?.dataSource = self
        self.view.addSubview(mainTableView!)
    }
    //设置导航栏标题大小
    fileprivate var labelView = UILabel()
    fileprivate var backButton = UIButton()
    fileprivate var infoDetailButton = UIButton()
    fileprivate var blackLine = UIView()
    fileprivate lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.white
        navigationCustom.alpha = 1
        return navigationCustom
    }()
    fileprivate lazy var anotherVC:AnotherInfoViewController? = {
        let anotherVC = AnotherInfoViewController()
        return anotherVC
    }()
    //设置头部
    fileprivate func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRect(x: -7, y: 20, width: 44, height: 44), image: "back_1", highImage: "back_2", selectedImage: nil, action: #selector(ConverseViewController.backButtonClick))
        self.setButton(infoDetailButton, frame: CGRect(x: AppWidth - 54, y: 20, width: 44, height: 44), image: "list_1", highImage: "list_1", selectedImage: nil, action: #selector(ConverseViewController.infoDetailButtonClick))
        self.labelView.text = self.model?.youName
        self.labelView.frame = CGRect(x: (AppWidth / 2) - 60, y: 20, width: 120, height: 44)
        self.labelView.font = UIFont.systemFont(ofSize: 16)
        self.labelView.adjustsFontSizeToFitWidth = true
        self.labelView.textAlignment = .center
        self.view.addSubview(labelView)
        self.blackLine.backgroundColor = UIColor.gray
        self.blackLine.frame = CGRect(x: 0, y: NavigationHeight - 0.5, width: AppWidth, height: 0.5)
        self.navigationCustom!.addSubview(blackLine)
    }
    @objc fileprivate func backButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc fileprivate func infoDetailButtonClick() {
        anotherVC?.model = self.model
        anotherVC?.isCreateMessageAble = true
        self.navigationController?.pushViewController(anotherVC!, animated: true)
    }
    
//    private func setTitleView() {
//        self.labelView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
//        self.labelView.text = self.model?.youName
//        self.labelView.textAlignment = .Center
//        self.labelView.font = UIFont.systemFontOfSize(16)
//        self.navigationItem.titleView = labelView
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setNavigation()
        self.mainTableView?.register(ConversationCell.self, forCellReuseIdentifier: ConversationCellId)
//        self.view.addSubview(keyboardBackView!)
        setMainTableView()
        setCancelEdit()
        setBottom()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//                self.navigationController?.setToolbarHidden(true, animated: true)

//        print(self.navigationController?.viewControllers.count)
//        for i in 0..<(self.navigationController?.viewControllers.count)! {
//            print(self.navigationController?.viewControllers[i])
//        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        print(self.navigationController?.viewControllers.first?.classForCoder)
//        ///移除navigation 的堆栈，
//        if (self.navigationController?.viewControllers.first is MessageViewController) {
////            print("mess")
//        }
//        else if (self.navigationController?.viewControllers.first is DescoverViewController) {
////            print("des")
//            print(self.navigationController?.viewControllers.count)
//            let num = (self.navigationController?.viewControllers.count)! - 1
//            let currentVC = self.navigationController?.viewControllers[num]
//            let messVC = MessageViewController()
//            self.navigationController?.setViewControllers([messVC,currentVC!], animated: true)
//        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.finalHeight = 0
        //        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
extension ConverseViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
//        let singleModel = singleMessageModel()
//        singleModel.icon = self.model?.icon
//        singleModel.myicon = (self.model?.myicon)!
//        singleModel.times = self.model?.times
//        singleModel.youName = self.model?.youName
//        
//        let cellText = self.model?.message![indexPath.row]
//        let key = [String](cellText!.keys).first
//        if key == "me" {
//            singleModel.type = 0
//        }
//        else if key == "other"{
//            singleModel.type = 1
//        }
//        singleModel.message = [String](cellText!.values).first
        cell = tableView.dequeueReusableCell(withIdentifier: ConversationCellId)
        (cell as! ConversationCell).model = multiModel[(indexPath as NSIndexPath).row]
        (cell as! ConversationCell).setModel(multiModel[(indexPath as NSIndexPath).row])
        cell?.selectionStyle = .none
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //判断tablecontentsize的高度来决定最终的显示位置
        //如果包含内容多于显示
        if tableView.contentSize.height > self.mainTableView?.frame.height {
            let finalY = tableView.contentSize.height - (self.mainTableView?.frame.height)!
            tableView.setContentOffset(CGPoint(x: 0, y: finalY), animated: false)
            self.finalHeight = tableView.contentSize.height
//            print(tableView.contentOffset.y + tableView.frame.height)
//            print(tableView.contentSize.height)
        }
        return self.multiModel.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        let height:CGFloat = tableView.cellHeightForIndexPath(indexPath, model: multiModel[indexPath.row], keyPath: "model", cellClass: ConversationCell.self, contentViewWidth: AppWidth)
        let height:CGFloat = tableView.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
        return height

    }


}
///编辑的代理
extension ConverseViewController:WriteViewDelegate {
    //编辑结束
    func writeViewShouldReturn(_ textField: UITextField) {
        let singleModel = singleMessageModel()
        singleModel.icon = self.model?.icon
        singleModel.myicon = (self.model?.myicon)!
        //获取当前时间
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let strNowTime = timeFormatter.string(from: date) as String
        singleModel.times = strNowTime
        singleModel.youName = self.model?.youName
        singleModel.type = 0
        singleModel.message = textField.text
        self.multiModel.append(singleModel)
        self.mainTableView?.reloadData()
        //需要更新MessageModel
        let transformModel = MessageModel()
        transformModel.icon = self.model?.icon
        transformModel.times = strNowTime
        transformModel.myicon = (self.model?.myicon)!
        transformModel.youName = self.model?.youName
        let messageNum = self.multiModel.count - 1
        transformModel.message = []
        if messageNum == -1 {
            transformModel.message = nil
        }
        for i in 0...messageNum {
//            print("in")
            let currentMessage = self.multiModel[i].message
//            print(currentMessage)
            let currentType = self.multiModel[i].type
            if currentType == 0 {
                let dict = ["me":currentMessage!]
                transformModel.message?.append(dict)
            }
            else {
                let dict = ["you":currentMessage!]
                transformModel.message?.append(dict)
            }
//            print(transformModel.message)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: MessageChangeNotification), object: transformModel)
    }
}

