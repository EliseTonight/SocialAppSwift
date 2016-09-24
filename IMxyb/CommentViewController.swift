//
//  CommentViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    
    
    
    //多个评论
    var model:[CommentModel]? {
        didSet {
            
        }
    }
    //主要的tableView
    fileprivate lazy var mainTabelView:UITableView? = {
        let mainTabelView = UITableView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight), style: UITableViewStyle.plain)
        mainTabelView.backgroundColor = UIColor.white
        mainTabelView.separatorStyle = .none
        return mainTabelView
    }()
    fileprivate var backButton = UIButton()
    fileprivate var headTitle = UILabel()
    //渐变Navigation
    fileprivate lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.white
        navigationCustom.alpha = 1
        return navigationCustom
    }()
    //书写button
    fileprivate var bottomView = WriteView.writeViewFromXib(CGRect(x: 0, y: AppHeight - 40, width: AppWidth, height: 40))
    //设置头部
    fileprivate func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRect(x: -7, y: 20, width: 44, height: 44), image: "back_1", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.headTitle.text = "全部回复"
        self.headTitle.frame = CGRect(x: (AppWidth / 2) - 40, y: 20, width: 80, height: 44)
        self.headTitle.font = UIFont.systemFont(ofSize: 16)
        self.headTitle.textAlignment = .center
        self.view.addSubview(headTitle)
    }
    //设置底部
    fileprivate func setBottom() {
        bottomView.alpha = 1.0
        self.view.addSubview(bottomView)
        NotificationCenter.default.addObserver(self, selector: "keyboardWillChangeFrame:", name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    //编辑开始与编辑结束，变化view的位置，添加监听器
    @objc fileprivate func keyboardWillChangeFrame(_ notify:Notification) {
        let info = (notify as NSNotification).userInfo
        let durationTime:Double = info![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardEndFrame:CGRect = (info![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let getMinY = keyboardEndFrame.minY
//        self.keyboardBackView?.hidden = !self.keyboardBackView!.hidden
        UIView.animate(withDuration: durationTime, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0, y: getMinY - 40, width: AppWidth, height: 40)
        }) 
    }
    //收回keyboard的背景覆盖view
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
        let tap = UITapGestureRecognizer(target: self, action: "cancelEdit")
        self.mainTabelView?.addGestureRecognizer(tap)
        self.mainTabelView?.isUserInteractionEnabled = true
    }
    
    @objc fileprivate func cancelEdit() {
        self.view.endEditing(true)
    }
    
    fileprivate func setContent() {
        self.mainTabelView?.delegate = self
        self.mainTabelView?.dataSource = self
        self.view.addSubview(mainTabelView!)
    }
    @objc fileprivate func backButtonClick(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setContent()
        setCancelEdit()
//        self.view.addSubview(keyboardBackView!)
        setBottom()
        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
extension CommentViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = CommentCell.commentCellWithXib(tableView)
        (cell as! CommentCell).model = self.model![(indexPath as NSIndexPath).row]
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
