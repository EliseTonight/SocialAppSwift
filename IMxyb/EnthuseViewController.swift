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
    fileprivate var commentViews:[SingleCommentView?] = []
    //最底部button
    fileprivate var moreCommentButton:MoreCommentButton?
    //最终webView长度
    fileprivate var finalWebHeight:CGFloat = 0
    
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
                        view.isHidden = true
                        view.model = model?.comment![i]
                        self.commentViews.append(view)
                        mainWebView?.scrollView.addSubview(view)
                    }
                }
            }
            //添加最后de button
            weak var selfRef = self
            self.moreCommentButton = MoreCommentButton.moreCommentButtonFromXib(CGRect(x: 0, y: (mainWebView?.scrollView.contentSize.height)!, width: AppWidth, height: 0))
            self.moreCommentButton?.isHidden = true
            self.moreCommentButton?.delegate = selfRef
            self.mainWebView?.scrollView.addSubview(moreCommentButton!)
            loadImageView?.endLoad()
            loadImageView?.removeFromSuperview()
        }
    }
    fileprivate var loadImageView:LoadAnimationView?
    //头部button
    fileprivate var backButton = UIButton()
    fileprivate var likeButton = UIButton()
    fileprivate var shareButton = UIButton()
    fileprivate var commentButton = UIButton()
    //承载View
    fileprivate lazy var mainScrollView:UIScrollView? = {
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight))
        return mainScrollView
    }()
    //webView头部
    fileprivate lazy var headWebView:HeadView? = {
        let headWebView = HeadView.headViewWithXib(CGRect(x: 0, y: -120, width: AppWidth, height: 120))
        return headWebView
    }()
    //内容
    fileprivate lazy var mainWebView:UIWebView? = {
        var webView = UIWebView(frame: CGRect(x: 0, y: NavigationHeight, width: AppWidth, height: AppHeight - NavigationHeight))
        webView.scrollView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -120), animated: false)
        webView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        webView.delegate = self
        return webView
    }()
    //shareView
    fileprivate lazy var shareView:ShareView? = {
        var shareView = ShareView.shareViewWithXib()
        return shareView
    }()
    //留言页面
    fileprivate lazy var commentMainView:CommentViewController? = {
        var commentMainView = CommentViewController()
        return commentMainView
    }()
    //渐变Navigation
    fileprivate lazy var navigationCustom:UIView? = {
        let navigationCustom = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        navigationCustom.backgroundColor = UIColor.white
        navigationCustom.alpha = 0.8
        return navigationCustom
    }()
    //设置内容
    fileprivate func setContent() {
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
    fileprivate func setNavigation() {
        self.view.addSubview(navigationCustom!)
        self.setButton(backButton, frame: CGRect(x: -7, y: 20, width: 44, height: 44), image: "back_1", highImage: "back_2", selectedImage: nil, action: "backButtonClick:")
        self.setButton(commentButton, frame: CGRect(x: AppWidth - 166, y: 20, width: 64, height: 44), image: "item-btn-comment-black-act", highImage: "item-btn-comment-black-act", selectedImage: nil, action: "commentButtonClick:")
        self.setButton(likeButton, frame: CGRect(x: AppWidth - 105, y: 20, width: 44, height: 44), image: "collect_1", highImage: "collect_0", selectedImage: "collect_2", action: "likeButtonClick:")
        self.setButton(shareButton, frame: CGRect(x: AppWidth - 54, y: 20, width: 44, height: 44), image: "share_1", highImage: "share_2", selectedImage: nil, action: "shareButtonClick:")
    }
    //buttonClick模块
    @objc fileprivate func shareButtonClick(_ sender:UIButton) {
        self.view.addSubview(shareView!)
        self.shareView!.showShareView(CGRect(x: 0, y: AppHeight - 155, width: AppWidth, height: 155))
    }
    @objc fileprivate func likeButtonClick(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @objc fileprivate func backButtonClick(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc fileprivate func commentButtonClick(_ sender:UIButton) {
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.mainWebView?.scrollView.contentSize.height = finalWebHeight
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
extension EnthuseViewController:UIWebViewDelegate {
    //在WebView加载之后添加头部与结尾回复，布局
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.showsHorizontalScrollIndicator = false
        for view in commentViews {
            view?.frame = CGRect(x: 0,y: webView.scrollView.contentSize.height, width: AppWidth, height: 100)
            view?.isHidden = false
            webView.scrollView.contentSize.height += 100
        }
        
        self.moreCommentButton?.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 80)
        self.moreCommentButton?.isHidden = false
        webView.scrollView.contentSize.height += 80
        finalWebHeight = webView.scrollView.contentSize.height
    }
}
extension EnthuseViewController:MoreCommentButtonDelegate {
    //即进入全部回复页面
    func moreCommentButton(_ sender: UIButton) {
        commentMainView?.model = self.model?.comment
        self.navigationController?.pushViewController(commentMainView!, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
