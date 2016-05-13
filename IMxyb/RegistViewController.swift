//
//  RegistViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {

    
    
    //loginView
    private lazy var loginView:LoginViewController? = {
        let loginView = LoginViewController()
        return loginView
    }()
    
    
    
    //正则表达式单例
    private var regExTools = RegExManager.sharedManager
    private var patternModel = RegExStrList()
    //验证码发送键的确认
    private var isAbleSend:Bool? {
        get {
            return isPhoneAble! && isAbleCount && isPasswordAble!
        }
    }
    //注册确认
    private var isAbleRegist: Bool? {
        get {
            return (isPhoneAble! && isPasswordAble! && isVerifyCodeAble!)
        }
    }
    //手机号是否可以
    private var isPhoneAble:Bool?  {
        get {
            return regExTools.getResultWithRegExStr(phoneTextFiled.text!, pattern: patternModel.regExPhoneStr)
        }
    }
    //密码是否可以
    private var isPasswordAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(passwordTextFiled.text!, pattern: patternModel.regExPasswordStr)
        }
    }
    //验证码是否可以
    private var isVerifyCodeAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(verifyText.text!, pattern: patternModel.regExVerifyCodeStr)
        }
    }
    //计时是否可以
    private var isAbleCount:Bool = true

    
    //AutoCountButton
    private var second = 60
    private var timer:NSTimer?
    
    
    
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "backImageClick")
            backImageView.userInteractionEnabled = true
            backImageView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneTextFiled: KaedeTextField!
    @IBOutlet weak var passwordTextFiled: KaedeTextField!
    @IBOutlet weak var verifyText: KaedeTextField!
    
    @IBOutlet weak var sendVerifyButton: UIButton! {
        didSet {
            sendVerifyButton.enabled = false
            sendVerifyButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        }
    }
    @IBOutlet weak var registButton: UIButton! {
        didSet {
            registButton.enabled = false
            registButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)

        }
    }
    
    
    @IBAction func sendVerifyButtonClick(sender: UIButton) {
        //发送
        if isAbleSend! {
            if !self.isPhoneHasEnrolled() {
                self.isAbleCount = false
                self.sendVerifyButton.enabled = self.isAbleSend!
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "sendVerifyButtonChange:", userInfo: nil, repeats: true)
                let user = AVUser()
                user.mobilePhoneNumber = self.phoneTextFiled.text!
                user.password = self.passwordTextFiled.text
                user.username = self.phoneTextFiled.text!
                SVProgressHUD.show()
                user.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                    if succeed {
                        SVProgressHUD.showSuccessWithStatus("发送成功")
                        dispatch_after(UInt64(1.5), dispatch_get_main_queue(), { () -> Void in
                            SVProgressHUD.dismiss()
                        })
                    }
                    else {
                        SVProgressHUD.showErrorWithStatus("发送失败")
                        dispatch_after(UInt64(1.5), dispatch_get_main_queue(), { () -> Void in
                            SVProgressHUD.dismiss()
                        })
                    }
                })
            }
        }
    }
    //手机号是否已注册
    private func isPhoneHasEnrolled() -> Bool {
        let queryWithPhone = AVUser.query()
        queryWithPhone.whereKey("mobilePhoneNumber", equalTo: phoneTextFiled.text)
        if queryWithPhone.findObjects().count == 0 {
            return false
        }
        else {
            SVProgressHUD.showErrorWithStatus("手机已经注册")
            dispatch_after(UInt64(1.5), dispatch_get_main_queue(), { () -> Void in
                SVProgressHUD.dismiss()
            })
            return true
        }
    
    }
    @objc private func sendVerifyButtonChange(timer:NSTimer) {
        let stringChange = "已发送\(second)"
        sendVerifyButton.titleLabel?.text = stringChange
        sendVerifyButton.setTitle(stringChange, forState: .Normal)
        second -= 1
        if second == 0 {
            second = 60
            isAbleCount = true
            sendVerifyButton.enabled = isAbleSend!
            sendVerifyButton.titleLabel?.text = "发送验证码"
            timer.invalidate()
            self.timer = nil
        }
    }
    

    @IBAction func backButtonClick(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    //注册按钮
    @IBAction func registButtonClick(sender: UIButton) {
        AVUser.verifyMobilePhone(verifyText.text!) { (succeed, error) -> Void in
            if succeed {
                SVProgressHUD.showSuccessWithStatus("注册成功")
                self.navigationController?.popViewControllerAnimated(true)
            }
            else {
                SVProgressHUD.showErrorWithStatus("注册失败")
                dispatch_after(UInt64(1.5), dispatch_get_main_queue(), { () -> Void in
                    SVProgressHUD.dismiss()
                })
            }
        }
        
    }
    private func appearAnimation() {
        UIView.animateWithDuration(1.0) { () -> Void in
            self.backImageView.alpha = 1.0
            self.backButton.alpha = 1.0
            self.phoneTextFiled.alpha = 1.0
            self.passwordTextFiled.alpha = 1.0
            self.verifyText.alpha = 1.0
            self.sendVerifyButton.alpha = 1.0
            self.registButton.alpha = 1.0
        }
    }
    private func disapperaAnimation() {
        UIView.animateWithDuration(1.0) { () -> Void in
            self.backImageView.alpha = 0.1
            self.backButton.alpha = 0.1
            self.phoneTextFiled.alpha = 0.1
            self.passwordTextFiled.alpha = 0.1
            self.verifyText.alpha = 0.1
            self.sendVerifyButton.alpha = 0.1
            self.registButton.alpha = 0.1

        }
    }
    //实时监测text的变化来确定bool值
    private func textValueGuard() {
        self.phoneTextFiled.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.passwordTextFiled.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.verifyText.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    @objc private func textValueChange(textField:KaedeTextField) {
        self.sendVerifyButton.enabled = isAbleSend!
        self.registButton.enabled = isAbleRegist!
    }
    
    
    func backImageClick() {
        view.endEditing(true)
    }
    //清除打字内容
    private func clearInput() {
        self.phoneTextFiled.text = nil
        self.passwordTextFiled.text = nil
        self.verifyText.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        textValueGuard()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.phoneTextFiled.resignFirstResponder()
        self.passwordTextFiled.resignFirstResponder()
        self.verifyText.resignFirstResponder()
        disapperaAnimation()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        self.isAbleCount = true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.phoneTextFiled.resignFirstResponder()
        self.passwordTextFiled.resignFirstResponder()
        self.verifyText.resignFirstResponder()
        appearAnimation()
        clearInput()
        self.sendVerifyButton.setTitle("发送验证码", forState: UIControlState.Normal)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
