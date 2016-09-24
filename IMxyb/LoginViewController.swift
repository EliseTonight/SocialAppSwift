//
//  LoginViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    fileprivate var userModel = currentUser()
    
    
    
    
    
    fileprivate lazy var meView:MeViewController? = {
        let meView = MeViewController()
        return meView
    }()
    //tools
    fileprivate var regExTools = RegExManager.sharedManager
    fileprivate var patternModel = RegExStrList()
    
    fileprivate var isPhoneAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(nameText.text!, pattern: patternModel.regExPhoneStr)
        }
    }
    fileprivate var isPasswordAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(passwordText.text!, pattern: patternModel.regExPasswordStr)
        }
    }
    fileprivate var isAbleLogin:Bool? {
        get {
            return (isPasswordAble! && isPhoneAble!)
        }
    }
    
    
    fileprivate lazy var registerView:RegistViewController? = {
        let registerView = RegistViewController()
        return registerView
    }()
    
    
    
    
    @IBOutlet weak var backImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "backImageClick")
            backImage.isUserInteractionEnabled = true
            backImage.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var nameText: KaedeTextField!
    @IBOutlet weak var passwordText: KaedeTextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        }
    }
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var weChatButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var qqButton: UIButton!
    
    @IBAction func qqButtonClick(_ sender: UIButton) {
        
    }
    @IBAction func weboButtonClick(_ sender: UIButton) {
        
    }

    @IBAction func weChatButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func newButtonClick(_ sender: UIButton) {
        self.navigationController?.pushViewController(registerView!, animated: true)
    }
    //登录按钮
    @IBAction func loginButtonClick(_ sender: UIButton) {
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
                SVProgressHUD.showSuccess(withStatus: "登录成功")
                UserPhone = "15112345678"
                self.navigationController?.popViewController(animated: true)
            }
            else {
                SVProgressHUD.showSuccess(withStatus: "登录失败")
            }
        }
        else {
            SVProgressHUD.showSuccess(withStatus: "登录失败")
        }
        
    }
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //d点击图片消失键盘
    func backImageClick() {
        view.endEditing(true)
    }
    
    //渐变显示
    fileprivate func apperaAnimate() {
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
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
        }) 
        
    }
    fileprivate func disappearAnimate() {
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
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
        }) 
    }
    //实时监测text的变化来确定bool值
    fileprivate func textValueGuard() {
        self.nameText.addTarget(self, action: "textValueChange:", for: UIControlEvents.editingChanged)
        self.passwordText.addTarget(self, action: "textValueChange:", for: UIControlEvents.editingChanged)
    }
    @objc fileprivate func textValueChange(_ textField:KaedeTextField) {
        self.loginButton.isEnabled = isAbleLogin!
    }
    
    //清除打字内容
    fileprivate func clearInput() {
        self.nameText.text = nil
        self.passwordText.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        textValueGuard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //取消焦点
        clearInput()
        self.nameText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        apperaAnimate()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //取消焦点
        self.nameText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
        disappearAnimate()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
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
