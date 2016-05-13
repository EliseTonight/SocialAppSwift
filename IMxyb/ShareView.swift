//
//  ShareView.swift
//  LittleDay
//
//  Created by Elise on 16/3/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

//公共的分享页面
class ShareView: UIView {
    
    weak var shareVC:UIViewController?
    
//    
//    var shareModel:ShareModel?
    
    @IBAction func weChatButton(sender: UIButton) {
        hideShareView()
    }
    
    @IBAction func friendsButton(sender: UIButton) {
        hideShareView()
    }
    
    @IBAction func sinaWeiboButton(sender: UIButton) {
        hideShareView()
    }

    //分享页面的黑色背景（button）
    private lazy var backButton:UIButton? =  {
        let backButton = UIButton(frame: AppSize)
        backButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        backButton.addTarget(self, action: "backButtonMethod", forControlEvents: UIControlEvents.TouchUpInside)
        return backButton
    }()
    
    
    
    
    
    
    
    
    class func shareViewWithXib() -> ShareView {
        let shareView = NSBundle.mainBundle().loadNibNamed("ShareView", owner: nil, options: nil).last as? ShareView
        //即正好处于显示的下面，被隐藏
        shareView?.frame = CGRectMake(0, AppHeight, AppWidth, 155)
        return shareView!
    }
    
    //展现分享页
    func showShareView(rect:CGRect) {
        self.superview?.insertSubview(backButton!, belowSubview: self)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.frame = rect
        }
    }
    func hideShareView() {
        backButton!.removeFromSuperview()
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.frame = CGRectMake(0, AppHeight, AppWidth, 215)
            }) { (final) -> Void in
                self.removeFromSuperview()
        }
        
    }

    func backButtonMethod() {
        hideShareView()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
