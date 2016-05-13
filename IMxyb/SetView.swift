////
////  SetView.swift
////  IMxyb
////
////  Created by Elise on 16/4/17.
////  Copyright © 2016年 Elise. All rights reserved.
////
//
//import UIKit
//
//class SetView: UIView {
//    
//    weak var delegate:SetViewDelegate?
//    
//    @IBOutlet weak var appStoreView: UIView! {
//        didSet {
//            appStoreView.setViewTap("appStoreViewClick")
//        }
//    }
//
//    @IBOutlet weak var shareView: UIView! {
//        didSet {
//            shareView.setViewTap("shareViewClick")
//        }
//    }
//    @IBOutlet weak var introMeView: UIView! {
//        didSet {
//            introMeView.setViewTap("introMeViewClick")
//        }
//    }
//    @IBOutlet weak var clearView: UIView! {
//        didSet {
//            clearView.setViewTap("clearViewClick")
//        }
//    }
//    /*
//    // Only override drawRect: if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
//    */
//    @objc private func appStoreViewClick() {
//        delegate?.appStoreViewClickDelegate()
//        print(1)
//    }
//    @objc private func shareViewClick() {
//        delegate?.shareViewClickDelegate()
//    }
//    @objc private func introMeViewClick() {
//        delegate?.introMeViewClickDelegate()
//    }
//    @objc private func clearViewClick() {
//        delegate?.clearViewClickDelegate()
//    }
//
//    
//    
//    
//    
//    class func setViewWithXib(frame:CGRect) -> SetView? {
//        let setView = NSBundle.mainBundle().loadNibNamed("SetView", owner: nil, options: nil).last as? SetView
//        setView?.frame = frame
//        return setView
//    }
//}
//
//@objc protocol SetViewDelegate {
//    @objc func introMeViewClickDelegate()
//    @objc func appStoreViewClickDelegate()
//    @objc func shareViewClickDelegate()
//    @objc func clearViewClickDelegate()
//}