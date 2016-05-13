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
    private lazy var mainTabelView:UITableView? = {
        let mainTabelView = UITableView(frame: CGRectMake(0, NavigationHeight, AppWidth, AppHeight - NavigationHeight), style: UITableViewStyle.Plain)
        mainTabelView.backgroundColor = UIColor.whiteColor()
        mainTabelView.separatorStyle = .None
        return mainTabelView
    }()
    private var backButton = UIButton()
    private var headTitle = UILabel()
    //渐变Navigation
    private lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.whiteColor()
        navigationCustom.alpha = 1
        return navigationCustom
    }()
    //书写button
    private var bottomView = WriteView.writeViewFromXib(CGRectMake(0, AppHeight - 40, AppWidth, 40))
    //设置头部
    private func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRectMake(-7, 20, 44, 44), image: "back_1", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.headTitle.text = "全部回复"
        self.headTitle.frame = CGRectMake((AppWidth / 2) - 40, 20, 80, 44)
        self.headTitle.font = UIFont.systemFontOfSize(16)
        self.headTitle.textAlignment = .Center
        self.view.addSubview(headTitle)
    }
    //设置底部
    private func setBottom() {
        bottomView.alpha = 1.0
        self.view.addSubview(bottomView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    //编辑开始与编辑结束，变化view的位置，添加监听器
    @objc private func keyboardWillChangeFrame(notify:NSNotification) {
        let info = notify.userInfo
        let durationTime:Double = info![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardEndFrame:CGRect = info![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        let getMinY = CGRectGetMinY(keyboardEndFrame)
//        self.keyboardBackView?.hidden = !self.keyboardBackView!.hidden
        UIView.animateWithDuration(durationTime) { () -> Void in
            self.bottomView.frame = CGRectMake(0, getMinY - 40, AppWidth, 40)
        }
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
    private func setCancelEdit() {
        let tap = UITapGestureRecognizer(target: self, action: "cancelEdit")
        self.mainTabelView?.addGestureRecognizer(tap)
        self.mainTabelView?.userInteractionEnabled = true
    }
    
    @objc private func cancelEdit() {
        self.view.endEditing(true)
    }
    
    private func setContent() {
        self.mainTabelView?.delegate = self
        self.mainTabelView?.dataSource = self
        self.view.addSubview(mainTabelView!)
    }
    @objc private func backButtonClick(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = CommentCell.commentCellWithXib(tableView)
        (cell as! CommentCell).model = self.model![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}