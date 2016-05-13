//
//  AnotherInfoViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AnotherInfoViewController: UIViewController {


    //隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
     var model:MessageModel? {
        didSet {
            topView.model = self.model
        }
    }
    //底部View
    private var bottomView = AnotherInfoBottomView.AnotherInfoBottonViewFromXib(CGRect(x: 0, y: AppHeight - 50, width: AppWidth, height: 50))
    //外部设置bottomView可不可见，，
    var isCreateMessageAble:Bool = false {
        didSet {
            self.bottomView.hidden = isCreateMessageAble
        }
    }
    
    
    
    private func setBottom() {
        weak var selfRef = self
        bottomView.delegate = selfRef
        self.view.addSubview(bottomView)
    }
    //渐变Navigation
    private lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.whiteColor()
        navigationCustom.alpha = 0.0
        return navigationCustom
    }()
    private var backButton = UIButton()
    private var likeButton = UIButton()
    private func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRectMake(-7, 20, 44, 44), image: "back_0", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.setButton(likeButton, frame: CGRectMake(AppWidth - 54, 20, 44, 44), image: "collect_0", highImage: "collect_2", selectedImage: "collect_2", action: "likeButtonClick:")
    }
    @objc  private func backButtonClick(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @objc private func likeButtonClick(sender:UIButton) {
        self.likeButton.selected = !self.likeButton.selected
    }
    //包含出底部之外的scrollview
    private lazy var backScrollView:UIScrollView? = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    
    //头部View
    private lazy var backImage:UIImageView? = {
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 240))
        backImage.image = UIImage(named: "deer")
        return backImage
    }()
    private var topView = AnotherInfoTopView.anotherInfoTopViewFromXib(CGRectMake(0, 0, AppWidth, 240))
    private var midView = AnotherInfoMidView.anotherInfoMidViewFromXib(CGRectMake(0, 240, AppWidth, 320))
    private func setTopAndMidView() {
        self.view.addSubview(backScrollView!)
        backScrollView?.delegate = self
        midView.delegate = self
        backScrollView?.addSubview(backImage!)
        backScrollView?.addSubview(topView)
        backScrollView?.addSubview(midView)
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置scrollView
        
        self.setTopAndMidView()
        

        
        //设置上部图
        self.setBottom()
        self.setNavigation()
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden =  true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
extension AnotherInfoViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //设置图片与导航的alpha值
        let offY = scrollView.contentOffset.y
        self.navigationCustom?.alpha = (offY / 240)
        if offY > 230 {
            self.backButton.setImage(UIImage(named: "back_1"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "collect_1"), forState: .Normal)
        }
        else {
            self.backButton.setImage(UIImage(named: "back_0"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "collect_0"), forState: .Normal)
        }
        if offY < 0 {
            self.backImage!.frame = CGRectMake(offY / 4, offY, AppWidth - offY / 2, 240 - offY)
        }
        
        
        
    }
}
extension AnotherInfoViewController:AnotherInfoBottomViewDelegate {
    func anotherInfoBottomViewButtonClick(sender: UIButton) {
//        if self.navigationController
//        self.model
        //获取当前时间
        var date = NSDate()
        var timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        self.model?.times = strNowTime
        self.model?.myicon = UserIcon ?? "logo_s"
        

        var isExsit = false
        //更新消息列表
        
        //如果重名存在就不增加,直接打开
        for oneMessage in AllMessageData {
            //非首次创建
            if oneMessage.youName == self.model?.youName {
                isExsit = true
                NSNotificationCenter.defaultCenter().postNotificationName(CreateNewConverFromDescoverVC, object: oneMessage)
                self.tabBarController?.selectedIndex = 1
//                let cellVC = ConverseViewController()
//                cellVC.model = oneMessage
//                self.navigationController?.pushViewController(cellVC, animated: true)
                break
            }
        }
        //首次创建
        if !isExsit {
            AllMessageData.insert(self.model!, atIndex: 0)
            NSNotificationCenter.defaultCenter().postNotificationName(CreateNewConverFromDescoverVC, object: self.model)
            self.tabBarController?.selectedIndex = 1
//            let cellVC = ConverseViewController()
//            cellVC.model = self.model!
//            self.navigationController?.pushViewController(cellVC, animated: true)
        }
//        self.navigationController?.pushViewController(cellVC, animated: true)
        
    }
}
extension AnotherInfoViewController:AnotherInfoMidViewDelegate {
    func signViewDelegate() {
        
    }
    func enthusViewDelegate() {
        
    }
    func academyViewDelegate() {
        
    }
    func proViewDelegate() {
        
    }
}
