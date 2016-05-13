//
//  EnthuseViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class EnthuseViewController: UIViewController{

    
    //存储留言
    private var commentViews:[SingleCommentView?] = []
    //最底部button
    private var moreCommentButton:MoreCommentButton?
    //最终webView长度
    private var finalWebHeight:CGFloat = 0
    
    var model:CustomCellModel? {
        didSet {
            self.loadImageView = LoadAnimationView()
            self.view.addSubview(loadImageView!)
            loadImageView?.startLoad(view.center)
            let htmlStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: (model?.content)!))
            self.mainWebView?.loadHTMLString((htmlStr as String), baseURL: nil)
            //动态加长（评论）
            let num = model?.comment?.count
            if num != nil && num != 0 {
                //添加两条留言
                for i in 0..<num! {
                    if i < 2 {
                        let view = SingleCommentView.singleCommentView(CGRect(x: 0, y: (mainWebView?.scrollView.contentSize.height)!, width: AppWidth, height: 100))
                        view.hidden = true
                        view.model = model?.comment![i]
                        self.commentViews.append(view)
                        mainWebView?.scrollView.addSubview(view)
                    }
                }
            }
            //添加最后de button
            weak var selfRef = self
            self.moreCommentButton = MoreCommentButton.moreCommentButtonFromXib(CGRectMake(0, (mainWebView?.scrollView.contentSize.height)!, AppWidth, 0))
            self.moreCommentButton?.hidden = true
            self.moreCommentButton?.delegate = selfRef
            self.mainWebView?.scrollView.addSubview(moreCommentButton!)
            loadImageView?.endLoad()
            loadImageView?.removeFromSuperview()
        }
    }
    private var loadImageView:LoadAnimationView?
    //头部button
    private var backButton = UIButton()
    private var likeButton = UIButton()
    private var shareButton = UIButton()
    private var commentButton = UIButton()
    //承载View
    private lazy var mainScrollView:UIScrollView? = {
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight))
        return mainScrollView
    }()
    //webView头部
    private lazy var headWebView:HeadView? = {
        let headWebView = HeadView.headViewWithXib(CGRect(x: 0, y: -120, width: AppWidth, height: 120))
        return headWebView
    }()
    //内容
    private lazy var mainWebView:UIWebView? = {
        var webView = UIWebView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight))
        webView.scrollView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -120), animated: false)
        webView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        webView.delegate = self
        return webView
    }()
    //shareView
    private lazy var shareView:ShareView? = {
        var shareView = ShareView.shareViewWithXib()
        return shareView
    }()
    //留言页面
    private lazy var commentMainView:CommentViewController? = {
        var commentMainView = CommentViewController()
        return commentMainView
    }()
    //渐变Navigation
    private lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.whiteColor()
        navigationCustom.alpha = 0.8
        return navigationCustom
    }()
    //设置内容
    private func setContent() {
//        self.view.addSubview(mainScrollView!)
//        mainScrollView?.addSubview(headWebView!)
//        mainScrollView?.addSubview(mainWebView!)
        self.view.clipsToBounds = true
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        self.view.addSubview(mainWebView!)
        self.mainWebView?.scrollView.addSubview(headWebView!)
        headWebView?.model = self.model
    }
    //设置头部
    private func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRectMake(-7, 20, 44, 44), image: "back_1", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.setButton(commentButton, frame: CGRectMake(AppWidth - 166, 20, 64, 44), image: "item-btn-comment-black-act", highImage: "item-btn-comment-black-act", selectedImage: nil, action: "commentButtonClick:")
        self.setButton(likeButton, frame: CGRectMake(AppWidth - 105, 20, 44, 44), image: "collect_1", highImage: "collect_0", selectedImage: "collect_2", action: "likeButtonClick:")
        self.setButton(shareButton, frame: CGRectMake(AppWidth - 54, 20, 44, 44), image: "share_1", highImage: "share_2", selectedImage: nil, action: "shareButtonClick:")
    }
    //buttonClick模块
    @objc private func shareButtonClick(sender:UIButton) {
        self.view.addSubview(shareView!)
        self.shareView!.showShareView(CGRectMake(0, AppHeight - 155, AppWidth, 155))
    }
    @objc private func likeButtonClick(sender:UIButton) {
        sender.selected = !sender.selected
    }
    @objc private func backButtonClick(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @objc private func commentButtonClick(sender:UIButton) {
        commentMainView?.model = self.model?.comment
        self.navigationController?.pushViewController(commentMainView!, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        setNavigation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.mainWebView?.scrollView.contentSize.height = finalWebHeight
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
extension EnthuseViewController:UIWebViewDelegate {
    //在WebView加载之后添加头部与结尾回复，布局
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.scrollView.showsHorizontalScrollIndicator = false
        for view in commentViews {
            view?.frame = CGRectMake(0,webView.scrollView.contentSize.height, AppWidth, 100)
            view?.hidden = false
            webView.scrollView.contentSize.height += 100
        }
        
        self.moreCommentButton?.frame = CGRectMake(0, webView.scrollView.contentSize.height, AppWidth, 80)
        self.moreCommentButton?.hidden = false
        webView.scrollView.contentSize.height += 80
        finalWebHeight = webView.scrollView.contentSize.height
    }
}
extension EnthuseViewController:MoreCommentButtonDelegate {
    //即进入全部回复页面
    func moreCommentButton(sender: UIButton) {
        commentMainView?.model = self.model?.comment
        self.navigationController?.pushViewController(commentMainView!, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
