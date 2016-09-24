//
//  SetViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    @IBOutlet weak var appStoreView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var introMeView: UIView!
    @IBOutlet weak var clearView: UIView!

    @objc fileprivate func appStoreViewClick() {
        
    }
    @objc fileprivate func shareViewClick() {
        
    }
    @objc fileprivate func introMeViewClick() {

    }
    @objc fileprivate func clearViewClick() {

    }

    fileprivate func setViewTap(_ view:UIView,action:Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    fileprivate func setAllViewTap() {
        self.setViewTap(appStoreView, action: "appStoreViewClick")
        self.setViewTap(shareView, action: "shareViewClick")
        self.setViewTap(introMeView, action: "introMeViewClick")
        self.setViewTap(clearView, action: "clearViewClick")
    }
//    
//    private lazy var setView:SetView? = {
//        let setView = SetView.setViewWithXib(CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
//        return setView
//    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SetView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllViewTap()
//        self.view.addSubview(setView!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
