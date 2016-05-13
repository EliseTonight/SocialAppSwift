//
//  LoginViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    private var userModel = currentUser()
    
    
    
    
    
    private lazy var meView:MeViewController? = {
        let meView = MeViewController()
        return meView
    }()
    //tools
    private var regExTools = RegExManager.sharedManager
    private var patternModel = RegExStrList()
    
    private var isPhoneAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(nameText.text!, pattern: patternModel.regExPhoneStr)
        }
    }
    private var isPasswordAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(passwordText.text!, pattern: patternModel.regExPasswordStr)
        }
    }
    private var isAbleLogin:Bool? {
        get {
            return (isPasswordAble! && isPhoneAble!)
        }
    }
    
    
    private lazy var registerView:RegistViewController? = {
        let registerView = RegistViewController()
        return registerView
    }()
    
    
    
    
    @IBOutlet weak var backImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "backImageClick")
            backImage.userInteractionEnabled = true
            backImage.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var nameText: KaedeTextField!
    @IBOutlet weak var passwordText: KaedeTextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.enabled = false
            loginButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        }
    }
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var weChatButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    
    @IBAction func qqButtonClick(sender: UIButton) {
        
    }
    @IBAction func weboButtonClick(sender: UIButton) {
        
    }

    @IBAction func weChatButtonClick(sender: UIButton) {
        
    }
    
    @IBAction func newButtonClick(sender: UIButton) {
        self.navigationController?.pushViewController(registerView!, animated: true)
    }
    //登录按钮
    @IBAction func loginButtonClick(sender: UIButton) {
//        SVProgressHUD.show()
//        AVUser.logInWithMobilePhoneNumberInBackground(nameText.text!, password: passwordText.text!) { (user, error) -> Void in
//            if error == nil {
//                SVProgressHUD.showSuccessWithStatus("登录成功")
//                AllMessageData.removeAll()
//                UserPhone = self.nameText.text!
//                let query = AVUser.query()
//                query.whereKey("mobilePhoneNumber", equalTo: UserPhone)
//                let object:AVObject? = query.getFirstObject()
//                UserId = object?.objectForKey("objectId") as? String
//                ///设置全局变量
//                if UserPhone == "" {
//                    UserIcon = "head"
//                }
//                else {
//                    UserIcon = "logo_s"
//                }
//                UserName = object?.objectForKey("username") as? String
//                UserFans = object?.objectForKey("fans") as? String
//                UserStars = object?.objectForKey("stars") as? String
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else {
//                SVProgressHUD.showErrorWithStatus("登录失败")
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
//                    SVProgressHUD.dismiss()
//                })
//            }
//        }
        if self.nameText.text == "15112345678" {
            if self.passwordText.text == "123456789" {
                SVProgressHUD.showSuccessWithStatus("登录成功")
                UserPhone = "15112345678"
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                SVProgressHUD.showSuccessWithStatus("登录失败")
            }
        }
        else {
            SVProgressHUD.showSuccessWithStatus("登录失败")
        }
        
    }
    @IBAction func backButtonClick(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //d点击图片消失键盘
    func backImageClick() {
        view.endEditing(true)
    }
    
    //渐变显示
    private func apperaAnimate() {
        UIView.animateWithDuration(0.7) { () -> Void in
            self.backImage.alpha = 1.0
            self.backButton.alpha = 1.0
            self.nameText.alpha = 1.0
            self.passwordText.alpha = 1.0
            self.loginButton.alpha = 1.0
            self.newButton.alpha = 1.0
            self.forgetButton.alpha = 1.0
            self.weChatButton.alpha = 0.8
            self.qqButton.alpha = 0.8
            self.weiboButton.alpha = 0.8
        }
        
    }
    private func disappearAnimate() {
        UIView.animateWithDuration(0.7) { () -> Void in
            self.backImage.alpha = 0.1
            self.backButton.alpha = 0.1
            self.nameText.alpha = 0.1
            self.passwordText.alpha = 0.1
            self.loginButton.alpha = 0.1
            self.newButton.alpha = 0.1
            self.forgetButton.alpha = 0.1
            self.weChatButton.alpha = 0.1
            self.qqButton.alpha = 0.1
            self.weiboButton.alpha = 0.1
        }
    }
    //实时监测text的变化来确定bool值
    private func textValueGuard() {
        self.nameText.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.passwordText.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    @objc private func textValueChange(textField:KaedeTextField) {
        self.loginButton.enabled = isAbleLogin!
    }
    
    //清除打字内容
    private func clearInput() {
        self.nameText.text = nil
        self.passwordText.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        textValueGuard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //取消焦点
        clearInput()
        self.nameText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        apperaAnimate()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //取消焦点
        self.nameText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        disappearAnimate()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.endEditing(false)
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
