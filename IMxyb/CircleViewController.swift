//
//  CircleViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    
    ///点击cell之前的当前index
    private var currentIndex:Int = 0
    
    
    
    //兴趣圈模型
    private var enthusModels:EnthusModels?
    ///校友圈模型
    private var schoolModel:SchoolModels?
    ///职业圈
    private var proModels:ProModels?
    //头部切换
    private var tableSwitchView:TableSwitchView?
    //分享View
    private var shareView:ShareView = ShareView.shareViewWithXib()
    
    
    private func setNavigation() {
        self.tableSwitchView = TableSwitchView(leftText: "职业圈", middleText: "校友圈", rightText: "兴趣圈")
        self.tableSwitchView?.frame = CGRectMake(0, 0, AppWidth, 44)
        self.tableSwitchView?.delegate = self
        self.navigationItem.titleView = tableSwitchView
    }
    //承载的ScrollView
    private lazy var mainScrollView:UIScrollView? = {
        let mainScrollView = UIScrollView()
        mainScrollView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight)
        mainScrollView.pagingEnabled = true
        mainScrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.contentSize = CGSize(width: 3 * AppWidth, height: 0)
        mainScrollView.delegate = self
        return mainScrollView
    }()
    //职业圈
    private lazy var professionTableView:UITableView? = {
        let professionTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 30 - 45), style: UITableViewStyle.Grouped)
        professionTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        professionTableView.separatorStyle = .None
        return professionTableView
    }()
    //校友圈
    private lazy var schoolMateTableView:UITableView? = {
        let schoolMateTableView = UITableView(frame: CGRect(x: AppWidth, y: 0, width: AppWidth, height: AppHeight - 30 - 45), style: UITableViewStyle.Grouped)
        schoolMateTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        schoolMateTableView.separatorStyle = .None
        return schoolMateTableView
    }()
    //兴趣圈
    private lazy var enthuseTableView:UITableView? = {
        let enthuseTableView = UITableView(frame: CGRect(x: AppWidth * 2, y: 0, width: AppWidth, height: AppHeight - 30 - 45), style: UITableViewStyle.Plain)
        enthuseTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        enthuseTableView.separatorStyle = .None
        return enthuseTableView
    }()
    //初始化三个table
    private func initMainView() {
        self.professionTableView?.dataSource = self
        self.professionTableView?.delegate = self
        self.schoolMateTableView?.dataSource = self
        self.schoolMateTableView?.delegate = self
        self.enthuseTableView?.dataSource = self
        self.enthuseTableView?.delegate = self
        self.setTableRefreshAnimation(self, refreshingAction: "loadProData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: professionTableView!)
        self.setTableRefreshAnimation(self, refreshingAction: "loadSchoolData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: schoolMateTableView!)
        self.setTableRefreshAnimation(self, refreshingAction: "loadEnthuseData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) / 2, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: enthuseTableView!)
        self.view.addSubview(mainScrollView!)
        mainScrollView?.addSubview(professionTableView!)
        mainScrollView?.addSubview(schoolMateTableView!)
        mainScrollView?.addSubview(enthuseTableView!)
    }
    //分享界面
    func shareButtonClick() {
        self.view.addSubview(shareView)
        shareView.showShareView(CGRect(x: 0, y: AppHeight - 215 - 45, width: AppWidth, height: 215))
    }
    
    
    
    //下拉刷新动画
    private func setTableRefreshAnimation(refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    ///职友圈的内容
    @objc private func loadProData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            //刷新动作
            ProModels.loadProModels({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    selfRefer?.professionTableView?.mj_header.endRefreshing()
                }
                else {
                    selfRefer?.proModels = data
                    selfRefer?.professionTableView?.reloadData()
                    selfRefer?.professionTableView?.mj_header.endRefreshing()
                }
            })
        }
    }
    ///校友圈的内容
    @objc private func loadSchoolData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            //刷新动作
            SchoolModels.loadSchoolsModels({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    selfRefer?.schoolMateTableView?.mj_header.endRefreshing()
                }
                else {
                    selfRefer?.schoolModel = data
                    selfRefer?.schoolMateTableView?.reloadData()
                    selfRefer?.schoolMateTableView?.mj_header.endRefreshing()
                }
            })
        }
    }
    ///兴趣圈的内容
    @objc private func loadEnthuseData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            //刷新动作
            EnthusModels.loadMeiTianMixModels({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    selfRefer?.enthuseTableView?.mj_header.endRefreshing()
                }
                else {
                    selfRefer?.enthusModels = data
                    selfRefer?.enthuseTableView?.reloadData()
                    selfRefer?.enthuseTableView?.mj_header.endRefreshing()
                }
            })
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        initMainView()
        
        
        
        //初始数据
        self.professionTableView?.mj_header.beginRefreshing()
        self.schoolMateTableView?.mj_header.beginRefreshing()
        self.enthuseTableView?.mj_header.beginRefreshing()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.tableSwitchView?.clickButtonWithIndex(self.currentIndex)
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
//按钮点击
extension CircleViewController:TableSwitchViewDelegate {
    
    func tableSwitchView(tableSwitchView: TableSwitchView, didSelectedButton button: UIButton, forIndex index: Int) {
        self.currentIndex = index
        mainScrollView?.setContentOffset(CGPoint(x: CGFloat(index) * AppWidth, y: 0), animated: true)

    }
}
extension CircleViewController:UIScrollViewDelegate {
    //减速停止后调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === mainScrollView {
            //拖动过一半就切换
            let index = Int(scrollView.contentOffset.x / AppWidth)
            self.currentIndex = index
            tableSwitchView?.clickButtonWithIndex(index)
        }
    }
}
extension CircleViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView === enthuseTableView {
//            print(enthusModels?.recommend_feeds?.count)
            return enthusModels?.recommend_feeds?.count ?? 0
        }
        else if tableView === schoolMateTableView {
            return schoolModel?.recommend_feeds?.count ?? 0
        }
        else {
            return proModels?.recommend_feeds?.count ?? 0
        }
    }
    //根据不同的tableView生成不同的cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if tableView === enthuseTableView {
            if self.enthusModels?.recommend_feeds![indexPath.row].photos_count == "0" {
                if self.enthusModels?.recommend_feeds![indexPath.row].cover_url == "" {
                    cell = CutomFontCell.cutomFontCellWithXib(tableView)
                    (cell as! CutomFontCell).model = self.enthusModels?.recommend_feeds![indexPath.row]
                }
                else {
                    cell = CustomCell.customCellWithXib(tableView)
                    (cell as! CustomCell).model = self.enthusModels?.recommend_feeds![indexPath.row]
                }
            }
            else  {
                cell = CustomPictureCell.cutomPictureCellWithXib(tableView)
                (cell as! CustomPictureCell).model = self.enthusModels?.recommend_feeds![indexPath.row]
            }
        }
        else if tableView === schoolMateTableView {
            if self.schoolModel?.recommend_feeds![indexPath.row].type == "学校" {
                cell = SchoolCell.schoolCellFromXib(tableView)
                (cell as! SchoolCell).model = self.schoolModel?.recommend_feeds![indexPath.row]
            }
            else {
                if self.schoolModel?.recommend_feeds![indexPath.row].photos_count == "0" {
                    if self.schoolModel?.recommend_feeds![indexPath.row].cover_url == "" {
                        cell = CutomFontCell.cutomFontCellWithXib(tableView)
                        (cell as! CutomFontCell).model = self.schoolModel?.recommend_feeds![indexPath.row]
                    }
                    else {
                        cell = CustomCell.customCellWithXib(tableView)
                        (cell as! CustomCell).model = self.schoolModel?.recommend_feeds![indexPath.row]
                    }
                }
                else  {
                    cell = CustomPictureCell.cutomPictureCellWithXib(tableView)
                    (cell as! CustomPictureCell).model = self.schoolModel?.recommend_feeds![indexPath.row]
                }

            }
        }
        else if tableView === professionTableView {
            if self.proModels?.recommend_feeds![indexPath.row].type == "职场" {
                cell = SchoolCell.schoolCellFromXib(tableView)
                (cell as! SchoolCell).model = self.proModels?.recommend_feeds![indexPath.row]
            }
            else {
                if self.proModels?.recommend_feeds![indexPath.row].photos_count == "0" {
                    if self.proModels?.recommend_feeds![indexPath.row].cover_url == "" {
                        cell = CutomFontCell.cutomFontCellWithXib(tableView)
                        (cell as! CutomFontCell).model = self.proModels?.recommend_feeds![indexPath.row]
                    }
                    else {
                        cell = CustomCell.customCellWithXib(tableView)
                        (cell as! CustomCell).model = self.proModels?.recommend_feeds![indexPath.row]
                    }
                }
                else  {
                    cell = CustomPictureCell.cutomPictureCellWithXib(tableView)
                    (cell as! CustomPictureCell).model = self.proModels?.recommend_feeds![indexPath.row]
                }
                
            }

        }
        return cell!
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === enthuseTableView {
            if self.enthusModels?.recommend_feeds![indexPath.row].photos_count == "0" {
                return 200
            }
            else {
                return 350
            }
        }
        else if tableView === professionTableView {
            if self.proModels?.recommend_feeds![indexPath.row].type == "职场" {
                return 253
            }
            else {
                if self.proModels?.recommend_feeds![indexPath.row].photos_count == "0" {
                    return 200
                }
                else {
                    return 350
                }
            }
        }
        else {
            if self.schoolModel?.recommend_feeds![indexPath.row].type == "学校" {
                return 253
            }
            else {
                 if self.schoolModel?.recommend_feeds![indexPath.row].photos_count == "0" {
                       return 200
                 }
                 else {
                       return 350
                 }
            }
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if tableView === enthuseTableView {
            let detailVC = EnthuseViewController()
            CustomCellModel.loadCustomCellModel({ (data, error) -> () in
                if data != nil {
                    detailVC.model = data
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            })
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}