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
    private var isFirst = true
    
    //friend的第一次
    private var isFriendFirst = true
    
    
    
    private var isAbleHasData = true
    //信息记录
    //模型
    var tools:MessageModels = MessageModels()
    
    
    
    var friendModel:[MessageModel]? {
        didSet {
        
        }
    }
    //信息的ViewC
    private lazy var anotherVC:AnotherInfoViewController? = {
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
    private  var noUserView:UIView?
    
    //backView,用来承载其他的view
    private lazy var backView:UIView? = {
        var backView:UIView = UIView(frame: AppSize)
        backView.backgroundColor = UIColor.whiteColor()
        return backView
    }()
    //好友tableView
    private lazy var friendTableView:UITableView? = {
        let friendTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - 45 - 60 - 10), style: UITableViewStyle.Plain)
        friendTableView.separatorStyle = .None
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return friendTableView
    }()
    //消息的tableView
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - 45 - 60 - 10), style: UITableViewStyle.Plain)
        mainTableView.separatorStyle = .None
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
    private func setTableRefreshAnimation(refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc private func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
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
    @objc private func loadFriend() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
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
    private func setMainTableView() {
//        mainScrollView?.addSubview(mainTableView!)
        mainTableView?.backgroundColor = UIColor.whiteColor()
        //添加两个view与承载
        self.view.addSubview(backView!)
        self.backView?.addSubview(friendTableView!)
        self.backView?.addSubview(mainTableView!)
        setTableRefreshAnimation(self, refreshingAction: "loadData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: mainTableView!)
        setTableRefreshAnimation(self, refreshingAction: "loadFriend", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: friendTableView!)
    }
    //popView
    //delegate 
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    private lazy var popViewContro:PopViewController? = {
        let popViewContro = PopViewController()
        return popViewContro
    }()
    //设置左侧与右侧
    private func setNavigationItem(imageName:String,enable:Bool) {
        //右侧
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "right_menu_nor"), style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonClick")
        self.navigationItem.rightBarButtonItem?.enabled = enable
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
    @objc private func rightButtonClick() {
        self.popViewContro?.modalPresentationStyle = .Popover
        self.popViewContro?.popoverPresentationController?.delegate = self
        self.popViewContro?.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.popViewContro?.preferredContentSize = CGSize(width: AppWidth * 0.4, height:123)
        self.presentViewController(self.popViewContro!, animated: true, completion: nil)
        
    }
    @objc private func leftButtonClick() {
        self.tabBarController?.selectedIndex = 3
    }
    //覆盖的View
    private var defaultView = DefaultView.defaultViewFromXib()
    private func setDefaultView() {
        weak var selfRef = self
        self.defaultView.delegate = selfRef
        self.view.addSubview(defaultView)
        self.defaultView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight)
    }
    ///切换的Button键
    let transformButton = UIButton()
    private func setTransformButton() {
        transformButton.frame = CGRectMake(AppWidth - NavigationHeight, AppHeight - NavigationHeight - 120, NavigationHeight, NavigationHeight)
        transformButton.alpha = 0.2
        transformButton.setImage(UIImage(named: "themelist"), forState: .Normal)
        transformButton.setImage(UIImage(named: "themeweb"), forState: .Selected)
        transformButton.addTarget(self, action: "transform:", forControlEvents: .TouchUpInside)
        view.addSubview(transformButton)
    }
    
    func transform(button:UIButton) {
        button.selected = !button.selected
        if button.selected {
            self.navigationItem.title = "我的好友"
            loadFriend()
            UIView.transitionFromView(mainTableView!, toView: friendTableView!, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        }
        else {
            self.navigationItem.title = "消息"
            loadData()
            UIView.transitionFromView(friendTableView!, toView: mainTableView!, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "消息"

        self.view.backgroundColor = UIColor.whiteColor()
        
        setMainTableView()
        
        mainTableView?.mj_header.beginRefreshing()
        friendTableView?.mj_header.beginRefreshing()
        
        setTransformButton()

        setDefaultView()
        
        ///添加通知监视器，可以通过监视来改变message的model
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageChange:", name: MessageChangeNotification, object: nil)
        ///添加通知监视器，可以通过监视来新建一个对话窗口
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "createNewConverse:", name: CreateNewConverFromDescoverVC, object: nil)

        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    ///接受改变的消息，处理信息改变模块：
    @objc private func messageChange(notice:NSNotification) {
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
    @objc private func createNewConverse(notice:NSNotification) {
        let getData:MessageModel = notice.object as! MessageModel
        let name = getData.youName
        let conVC = ConverseViewController()
        conVC.model = getData
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.navigationController?.pushViewController(conVC, animated: true)
        }
    }
    
    
    
    
    
    //MARK: - 登录信息判断模块
    private func loginInfoJudge() {
        if UserPhone == nil {
            self.defaultView.hidden = false
            self.isAbleHasData = false
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
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        loginInfoJudge()

    }
    override func viewDidAppear(animated: Bool) {
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        if tableView === mainTableView {
            cell = MessageCell.messageCellWithXib(tableView)
            //        print(self.model![indexPath.row].icon)
            //         print(self.model![indexPath.row].youName)
            //         print(self.model![indexPath.row].message)
            //         print(self.model![indexPath.row].times)
            //         print(self.model![indexPath.row].myicon)
            (cell as! MessageCell).model = self.model![indexPath.row]
        }
        else {
            cell = FriendCell.friendCellFromXib(tableView)
            (cell as! FriendCell).model = self.friendModel![indexPath.row]
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat?
        if tableView === mainTableView {
            height = 60
        }
        else {
            height = 50
        }
        return height!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView === mainTableView {
            let cellModels = self.model![indexPath.row]
            let cellVC = ConverseViewController()
            cellVC.model = cellModels
            self.navigationController?.pushViewController(cellVC, animated: true)
        }
        else {
            anotherVC?.model = self.friendModel![indexPath.row]
            anotherVC?.isCreateMessageAble = false
            self.navigationController?.pushViewController(anotherVC!, animated: true)
        }
    }
    
    //cell的编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let topAct = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "置顶") { (action, index) -> Void in
            //排序
            let now = self.model?[indexPath.row]
            self.model?.removeAtIndex(indexPath.row)
            self.model?.insert(now!, atIndex: 0)
            AllMessageData = self.model!
            tableView.reloadData()

        }
        let deletAct = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "删除") { (action, index) -> Void in
            self.model?.removeAtIndex(indexPath.row)
            AllMessageData = self.model!
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        return [deletAct,topAct]
    }
    
 
    
    
    
}
extension MessageViewController:UIScrollViewDelegate {
    
}
