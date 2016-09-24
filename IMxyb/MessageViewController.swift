//
//  MessageViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

///通过通讯录打开
public let CreateNewConverFromDescoverVC = "CreateNewConverFromDescoverVC"


public let FriendCellId = "FriendCell"

class MessageViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    //是否第一次加载，是否是允许有数据
    fileprivate var isFirst = true
    
    //friend的第一次
    fileprivate var isFriendFirst = true
    
    
    
    fileprivate var isAbleHasData = true
    //信息记录
    //模型
    var tools:MessageModels = MessageModels()
    
    
    
    var friendModel:[MessageModel]? {
        didSet {
        
        }
    }
    //信息的ViewC
    fileprivate lazy var anotherVC:AnotherInfoViewController? = {
        let anotherVC = AnotherInfoViewController()
        return anotherVC
    }()
    
    
    //在设定好之后，在加载friend的模型
    var model:[MessageModel]? {
        didSet {
//            self.mainScrollView?.contentSize.height = AppHeight + CGFloat(100 * ((model?.count)! - 5))
//            let height
//            if self.isFriendFirst {
//                self.isFriendFirst = false
//                self.friendModel = model
//            }
        }
    }
    //如果没有当前用户提示需要先登录
    fileprivate  var noUserView:UIView?
    
    //backView,用来承载其他的view
    fileprivate lazy var backView:UIView? = {
        var backView:UIView = UIView(frame: AppSize)
        backView.backgroundColor = UIColor.white
        return backView
    }()
    //好友tableView
    fileprivate lazy var friendTableView:UITableView? = {
        let friendTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 45 - 60 - 10), style: UITableViewStyle.plain)
        friendTableView.separatorStyle = .none
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return friendTableView
    }()
    //消息的tableView
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 45 - 60 - 10), style: UITableViewStyle.plain)
        mainTableView.separatorStyle = .none
        mainTableView.delegate = self
        mainTableView.dataSource = self
        return mainTableView
    }()
    //承载的ScrollView
//    private lazy var mainScrollView:UIScrollView? = {
//        let mainScrollView = UIScrollView(frame: AppSize)
//        mainScrollView.delegate = self
//        mainScrollView.showsHorizontalScrollIndicator = false
//        return mainScrollView
//    }()
    
    
    //下拉刷新动画
    fileprivate func setTableRefreshAnimation(_ refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header?.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc fileprivate func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = DispatchTime.now() + Double(Int64(0.8 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            //刷新动作
            if self.isAbleHasData {
                if self.isFirst {
                    self.tools.deleteAllData()
                    self.tools.initRandomData()
//                    print(1)
//                    print(AllMessageData.count)
                    self.model = AllMessageData
                    self.isFirst = false
                    selfRefer?.mainTableView?.reloadData()
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                }
                else {
//                    print(2)
//                    print(AllMessageData.count)
                    self.model = AllMessageData
                    selfRefer?.mainTableView?.reloadData()
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                }
            }
            else {
                self.model = AllMessageData
                selfRefer?.mainTableView?.reloadData()
                selfRefer?.mainTableView?.mj_header.endRefreshing()
            }
        }
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc fileprivate func loadFriend() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = DispatchTime.now() + Double(Int64(0.8 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            //刷新动作
            if self.friendModel == nil {
                if self.isFriendFirst {
                    self.isFriendFirst = false
                    self.friendModel = AllMessageData
                    selfRefer?.friendTableView?.reloadData()
                    selfRefer?.friendTableView?.mj_header.endRefreshing()
                }
                else {
                    self.friendModel = AllMessageData
                    selfRefer?.friendTableView?.reloadData()
                    selfRefer?.friendTableView?.mj_header.endRefreshing()
                }
            }
                
            else {
                self.friendModel = AllMessageData
                selfRefer?.friendTableView?.reloadData()
                selfRefer?.friendTableView?.mj_header.endRefreshing()
            }
        }
    }
    fileprivate func setMainTableView() {
//        mainScrollView?.addSubview(mainTableView!)
        mainTableView?.backgroundColor = UIColor.white
        //添加两个view与承载
        self.view.addSubview(backView!)
        self.backView?.addSubview(friendTableView!)
        self.backView?.addSubview(mainTableView!)
        setTableRefreshAnimation(self, refreshingAction: #selector(MessageViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: mainTableView!)
        setTableRefreshAnimation(self, refreshingAction: #selector(MessageViewController.loadFriend), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: friendTableView!)
    }
    //popView
    //delegate 
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    fileprivate lazy var popViewContro:PopViewController? = {
        let popViewContro = PopViewController()
        return popViewContro
    }()
    //设置左侧与右侧
    fileprivate func setNavigationItem(_ imageName:String,enable:Bool) {
        //右侧
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "right_menu_nor"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MessageViewController.rightButtonClick))
        self.navigationItem.rightBarButtonItem?.isEnabled = enable
        //左侧
        let imageView = CornerImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        imageView.image = UIImage(named: imageName)
        imageView.cornerRadius = 18
        let tap = UITapGestureRecognizer(target: self, action: #selector(MessageViewController.leftButtonClick))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        self.navigationItem.leftBarButtonItem?.isEnabled = enable
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: CornerImageView(image: UIImage(named: "head")), style: UIBarButtonItemStyle.Plain, target: self, action: "leftButtonClick")
    }
    @objc fileprivate func rightButtonClick() {
        self.popViewContro?.modalPresentationStyle = .popover
        self.popViewContro?.popoverPresentationController?.delegate = self
        self.popViewContro?.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.popViewContro?.preferredContentSize = CGSize(width: AppWidth * 0.4, height:123)
        self.present(self.popViewContro!, animated: true, completion: nil)
        
    }
    @objc fileprivate func leftButtonClick() {
        self.tabBarController?.selectedIndex = 3
    }
    //覆盖的View
    fileprivate var defaultView = DefaultView.defaultViewFromXib()
    fileprivate func setDefaultView() {
        weak var selfRef = self
        self.defaultView.delegate = selfRef
        self.view.addSubview(defaultView)
        self.defaultView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight)
    }
    ///切换的Button键
    let transformButton = UIButton()
    fileprivate func setTransformButton() {
        transformButton.frame = CGRect(x: AppWidth - NavigationHeight, y: AppHeight - NavigationHeight - 120, width: NavigationHeight, height: NavigationHeight)
        transformButton.alpha = 0.2
        transformButton.setImage(UIImage(named: "themelist"), for: UIControlState())
        transformButton.setImage(UIImage(named: "themeweb"), for: .selected)
        transformButton.addTarget(self, action: #selector(MessageViewController.transform(_:)), for: .touchUpInside)
        view.addSubview(transformButton)
    }
    
    func transform(_ button:UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            self.navigationItem.title = "我的好友"
            loadFriend()
            UIView.transition(from: mainTableView!, to: friendTableView!, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        }
        else {
            self.navigationItem.title = "消息"
            loadData()
            UIView.transition(from: friendTableView!, to: mainTableView!, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "消息"

        self.view.backgroundColor = UIColor.white
        
        setMainTableView()
        
        mainTableView?.mj_header.beginRefreshing()
        friendTableView?.mj_header.beginRefreshing()
        
        setTransformButton()

        setDefaultView()
        
        ///添加通知监视器，可以通过监视来改变message的model
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.messageChange(_:)), name: NSNotification.Name(rawValue: MessageChangeNotification), object: nil)
        ///添加通知监视器，可以通过监视来新建一个对话窗口
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.createNewConverse(_:)), name: NSNotification.Name(rawValue: CreateNewConverFromDescoverVC), object: nil)

        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///接受改变的消息，处理信息改变模块：
    @objc fileprivate func messageChange(_ notice:Notification) {
//        print("get")
        let getData:MessageModel = notice.object as! MessageModel
        let name = getData.youName
//        print(getData.times)
//        print(getData.youName)
        
        var isExist = false
        ///判断更新信息是否是存在的，还是新的
        for i in 0..<AllMessageData.count {
            ///如果已经存在，则更新对应的
            if AllMessageData[i].youName == name {
                AllMessageData[i] = getData
                isExist = true
                break
            }
        }
        ///如果不存在@，则在第一条插入
        if !isExist {
            AllMessageData.append(getData)
        }
        mainTableView?.mj_header.beginRefreshing()
    }
    
    ///通过通讯录创建
    @objc fileprivate func createNewConverse(_ notice:Notification) {
        let getData:MessageModel = notice.object as! MessageModel
        let name = getData.youName
        let conVC = ConverseViewController()
        conVC.model = getData
        let time = DispatchTime.now() + Double(Int64(0.05 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            self.navigationController?.pushViewController(conVC, animated: true)
        }
    }
    
    
    
    
    
    //MARK: - 登录信息判断模块
    fileprivate func loginInfoJudge() {
        if UserPhone == nil {
            self.defaultView.isHidden = false
            self.isAbleHasData = false
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginInfoJudge()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isAbleHasData {
            mainTableView?.mj_header.beginRefreshing()
            friendTableView?.mj_header.beginRefreshing()
//            self.loadData()
//            self.
        }
        
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
//即默认界面的登录
extension MessageViewController:DefaultViewDelegate {
    func defaultViewTapDelegate() {
        self.tabBarController?.selectedIndex = 3
    }
}
extension MessageViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === mainTableView {
            if isAbleHasData {
                return model?.count ?? 0
            }else {
                return 0
            }
        }
        else {
            return friendModel?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        if tableView === mainTableView {
            cell = MessageCell.messageCellWithXib(tableView)
            //        print(self.model![indexPath.row].icon)
            //         print(self.model![indexPath.row].youName)
            //         print(self.model![indexPath.row].message)
            //         print(self.model![indexPath.row].times)
            //         print(self.model![indexPath.row].myicon)
            (cell as! MessageCell).model = self.model![(indexPath as NSIndexPath).row]
        }
        else {
            cell = FriendCell.friendCellFromXib(tableView)
            (cell as! FriendCell).model = self.friendModel![(indexPath as NSIndexPath).row]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat?
        if tableView === mainTableView {
            height = 60
        }
        else {
            height = 50
        }
        return height!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === mainTableView {
            let cellModels = self.model![(indexPath as NSIndexPath).row]
            let cellVC = ConverseViewController()
            cellVC.model = cellModels
            self.navigationController?.pushViewController(cellVC, animated: true)
        }
        else {
            anotherVC?.model = self.friendModel![(indexPath as NSIndexPath).row]
            anotherVC?.isCreateMessageAble = false
            self.navigationController?.pushViewController(anotherVC!, animated: true)
        }
    }
    
    //cell的编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView === mainTableView {
            return true
        }
        else {
            return false
        }
    }
//    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        if indexPath.row != 0 {
//            return true
//        }
//        else {
//            return false
//        }
//    }
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete
//    }
//    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
//        return "删除"
//    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            print("asd")
//        }
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let topAct = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "置顶") { (action, index) -> Void in
            //排序
            let now = self.model?[(indexPath as NSIndexPath).row]
            self.model?.remove(at: (indexPath as NSIndexPath).row)
            self.model?.insert(now!, at: 0)
            AllMessageData = self.model!
            tableView.reloadData()

        }
        let deletAct = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "删除") { (action, index) -> Void in
            self.model?.remove(at: (indexPath as NSIndexPath).row)
            AllMessageData = self.model!
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        return [deletAct,topAct]
    }
    
 
    
    
    
}
extension MessageViewController:UIScrollViewDelegate {
    
}
