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
    override var prefersStatusBarHidden : Bool {
        return true
    }
     var model:MessageModel? {
        didSet {
            topView.model = self.model
        }
    }
    //底部View
    fileprivate var bottomView = AnotherInfoBottomView.AnotherInfoBottonViewFromXib(CGRect(x: 0, y: AppHeight - 50, width: AppWidth, height: 50))
    //外部设置bottomView可不可见，，
    var isCreateMessageAble:Bool = false {
        didSet {
            self.bottomView.isHidden = isCreateMessageAble
        }
    }
    
    
    
    fileprivate func setBottom() {
        weak var selfRef = self
        bottomView.delegate = selfRef
        self.view.addSubview(bottomView)
    }
    //渐变Navigation
    fileprivate lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.white
        navigationCustom.alpha = 0.0
        return navigationCustom
    }()
    fileprivate var backButton = UIButton()
    fileprivate var likeButton = UIButton()
    fileprivate func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRect(x: -7, y: 20, width: 44, height: 44), image: "back_0", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.setButton(likeButton, frame: CGRect(x: AppWidth - 54, y: 20, width: 44, height: 44), image: "collect_0", highImage: "collect_2", selectedImage: "collect_2", action: "likeButtonClick:")
    }
    @objc  fileprivate func backButtonClick(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc fileprivate func likeButtonClick(_ sender:UIButton) {
        self.likeButton.isSelected = !self.likeButton.isSelected
    }
    //包含出底部之外的scrollview
    fileprivate lazy var backScrollView:UIScrollView? = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.white
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    
    //头部View
    fileprivate lazy var backImage:UIImageView? = {
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 240))
        backImage.image = UIImage(named: "deer")
        return backImage
    }()
    fileprivate var topView = AnotherInfoTopView.anotherInfoTopViewFromXib(CGRect(x: 0, y: 0, width: AppWidth, height: 240))
    fileprivate var midView = AnotherInfoMidView.anotherInfoMidViewFromXib(CGRect(x: 0, y: 240, width: AppWidth, height: 320))
    fileprivate func setTopAndMidView() {
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden =  true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //设置图片与导航的alpha值
        let offY = scrollView.contentOffset.y
        self.navigationCustom?.alpha = (offY / 240)
        if offY > 230 {
            self.backButton.setImage(UIImage(named: "back_1"), for: UIControlState())
            self.likeButton.setImage(UIImage(named: "collect_1"), for: UIControlState())
        }
        else {
            self.backButton.setImage(UIImage(named: "back_0"), for: UIControlState())
            self.likeButton.setImage(UIImage(named: "collect_0"), for: UIControlState())
        }
        if offY < 0 {
            self.backImage!.frame = CGRect(x: offY / 4, y: offY, width: AppWidth - offY / 2, height: 240 - offY)
        }
        
        
        
    }
}
extension AnotherInfoViewController:AnotherInfoBottomViewDelegate {
    func anotherInfoBottomViewButtonClick(_ sender: UIButton) {
//        if self.navigationController
//        self.model
        //获取当前时间
        var date = Date()
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        var strNowTime = timeFormatter.string(from: date) as String
        self.model?.times = strNowTime
        self.model?.myicon = UserIcon ?? "logo_s"
        

        var isExsit = false
        //更新消息列表
        
        //如果重名存在就不增加,直接打开
        for oneMessage in AllMessageData {
            //非首次创建
            if oneMessage.youName == self.model?.youName {
                isExsit = true
                NotificationCenter.default.post(name: Notification.Name(rawValue: CreateNewConverFromDescoverVC), object: oneMessage)
                self.tabBarController?.selectedIndex = 1
//                let cellVC = ConverseViewController()
//                cellVC.model = oneMessage
//                self.navigationController?.pushViewController(cellVC, animated: true)
                break
            }
        }
        //首次创建
        if !isExsit {
            AllMessageData.insert(self.model!, at: 0)
            NotificationCenter.default.post(name: Notification.Name(rawValue: CreateNewConverFromDescoverVC), object: self.model)
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
