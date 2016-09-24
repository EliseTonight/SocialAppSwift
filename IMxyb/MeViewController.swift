//
//  MeViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    
    
    
    

    
    //登录界面
    fileprivate lazy var loginView:LoginViewController? = {
        let loginView = LoginViewController()
        return loginView
    }()
    //个人信息
    fileprivate lazy var inforView:InforViewController? = {
        let inforView = InforViewController()
        return inforView
    }()
    
    //有关页面
    fileprivate var meMainView = MeMainView.meMainViewWithXib()
    fileprivate var topImageHeight:CGFloat?
    
    fileprivate lazy var scrollView:UIScrollView? = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 64 - 45))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        scrollView.alwaysBounceVertical = true
        scrollView.contentSize = CGSize(width: AppWidth, height: 555)
        scrollView.delegate = self
        return scrollView
    }()
    //摇一摇界面
    fileprivate lazy var shakeViewC:ShakeViewController? = {
        let shakeViewC = ShakeViewController()
        return shakeViewC
    }()

    //设置导航栏
    fileprivate func setNavigation() {
        self.navigationItem.title = "我的"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "setting"), style: UIBarButtonItemStyle.plain, target: self, action: "setButtonClick")
    }
    //设置
    fileprivate lazy var setView:SetViewController? = {
        let setView = SetViewController()
        return setView
    }()
    @objc fileprivate func setButtonClick() {
        self.navigationController?.pushViewController(setView!, animated: true)
    }
    
    
    fileprivate func setMainView() {
        weak var selfRef = self
        self.meMainView.model = UserPhone
        self.meMainView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 551)
        meMainView.delegate = selfRef
        self.topImageHeight = meMainView.topImage.frame.height
        self.scrollView?.addSubview(meMainView)
        self.view.addSubview(scrollView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setNavigation()
        setMainView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //即刷新界面
        self.meMainView.model = UserPhone
        SVProgressHUD.dismiss()
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
extension MeViewController :MeMainViewDelegate{
    func shakeButtonDelegate(_ sender: UIButton) {
        
        self.navigationController?.pushViewController(shakeViewC!, animated: true)
    }
    //如果没当前用户则进入登录界面，如果有，则进入。
    func headImageDelegate() {
        
        if UserPhone == nil {
            self.navigationController?.pushViewController(loginView!, animated: true)
        }
        else {
            inforView?.model = "1"
            self.navigationController?.pushViewController(inforView!, animated: true)
        }
    }
    
    
    
    

}
//uiscrollView
extension MeViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY <= 0 {
            meMainView.topImage.frame = CGRect(x: offSetY / 4, y: offSetY, width: AppWidth - offSetY / 2,height: self.topImageHeight! - offSetY)
        }
        else {
            meMainView.topImage.frame.origin.y = 0
        }
    }
}
