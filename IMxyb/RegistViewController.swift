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
    fileprivate lazy var loginView:LoginViewController? = {
        let loginView = LoginViewController()
        return loginView
    }()
    
    
    
    //正则表达式单例
    fileprivate var regExTools = RegExManager.sharedManager
    fileprivate var patternModel = RegExStrList()
    //验证码发送键的确认
    fileprivate var isAbleSend:Bool? {
        get {
            return isPhoneAble! && isAbleCount && isPasswordAble!
        }
    }
    //注册确认
    fileprivate var isAbleRegist: Bool? {
        get {
            return (isPhoneAble! && isPasswordAble! && isVerifyCodeAble!)
        }
    }
    //手机号是否可以
    fileprivate var isPhoneAble:Bool?  {
        get {
            return regExTools.getResultWithRegExStr(phoneTextFiled.text!, pattern: patternModel.regExPhoneStr)
        }
    }
    //密码是否可以
    fileprivate var isPasswordAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(passwordTextFiled.text!, pattern: patternModel.regExPasswordStr)
        }
    }
    //验证码是否可以
    fileprivate var isVerifyCodeAble:Bool? {
        get {
            return regExTools.getResultWithRegExStr(verifyText.text!, pattern: patternModel.regExVerifyCodeStr)
        }
    }
    //计时是否可以
    fileprivate var isAbleCount:Bool = true

    
    //AutoCountButton
    fileprivate var second = 60
    fileprivate var timer:Timer?
    
    
    
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(RegistViewController.backImageClick))
            backImageView.isUserInteractionEnabled = true
            backImageView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneTextFiled: KaedeTextField!
    @IBOutlet weak var passwordTextFiled: KaedeTextField!
    @IBOutlet weak var verifyText: KaedeTextField!
    
    @IBOutlet weak var sendVerifyButton: UIButton! {
        didSet {
            sendVerifyButton.isEnabled = false
            sendVerifyButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        }
    }
    @IBOutlet weak var registButton: UIButton! {
        didSet {
            registButton.isEnabled = false
            registButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)

        }
    }
    
    
    @IBAction func sendVerifyButtonClick(_ sender: UIButton) {
        //发送
        if isAbleSend! {
            if !self.isPhoneHasEnrolled() {
                self.isAbleCount = false
                self.sendVerifyButton.isEnabled = self.isAbleSend!
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(RegistViewController.sendVerifyButtonChange(_:)), userInfo: nil, repeats: true)
                let user = AVUser()
                user.mobilePhoneNumber = self.phoneTextFiled.text!
                user.password = self.passwordTextFiled.text
                user.username = self.phoneTextFiled.text!
                SVProgressHUD.show()
                user.signUpInBackground({ (succeed, error) -> Void in
                    if succeed {
                        SVProgressHUD.showSuccess(withStatus: "发送成功")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1.5)), execute: { () -> Void in
                            SVProgressHUD.dismiss()
                        })
                    }
                    else {
                        SVProgressHUD.showError(withStatus: "发送失败")
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1.5)), execute: { () -> Void in
                            SVProgressHUD.dismiss()
                        })
                    }
                })
            }
        }
    }
    //手机号是否已注册
    fileprivate func isPhoneHasEnrolled() -> Bool {
        let queryWithPhone = AVUser.query()
        queryWithPhone?.whereKey("mobilePhoneNumber", equalTo: phoneTextFiled.text)
        if queryWithPhone?.findObjects().count == 0 {
            return false
        }
        else {
            SVProgressHUD.showError(withStatus: "手机已经注册")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1.5)), execute: { () -> Void in
                SVProgressHUD.dismiss()
            })
            return true
        }
    
    }
    @objc fileprivate func sendVerifyButtonChange(_ timer:Timer) {
        let stringChange = "已发送\(second)"
        sendVerifyButton.titleLabel?.text = stringChange
        sendVerifyButton.setTitle(stringChange, for: UIControlState())
        second -= 1
        if second == 0 {
            second = 60
            isAbleCount = true
            sendVerifyButton.isEnabled = isAbleSend!
            sendVerifyButton.titleLabel?.text = "发送验证码"
            timer.invalidate()
            self.timer = nil
        }
    }
    

    @IBAction func backButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //注册按钮
    @IBAction func registButtonClick(_ sender: UIButton) {
        AVUser.verifyMobilePhone(verifyText.text!) { (succeed, error) -> Void in
            if succeed {
                SVProgressHUD.showSuccess(withStatus: "注册成功")
                self.navigationController?.popViewController(animated: true)
            }
            else {
                SVProgressHUD.showError(withStatus: "注册失败")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1.5)), execute: { () -> Void in
                    SVProgressHUD.dismiss()
                })
            }
        }
        
    }
    fileprivate func appearAnimation() {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.backImageView.alpha = 1.0
            self.backButton.alpha = 1.0
            self.phoneTextFiled.alpha = 1.0
            self.passwordTextFiled.alpha = 1.0
            self.verifyText.alpha = 1.0
            self.sendVerifyButton.alpha = 1.0
            self.registButton.alpha = 1.0
        }) 
    }
    fileprivate func disapperaAnimation() {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.backImageView.alpha = 0.1
            self.backButton.alpha = 0.1
            self.phoneTextFiled.alpha = 0.1
            self.passwordTextFiled.alpha = 0.1
            self.verifyText.alpha = 0.1
            self.sendVerifyButton.alpha = 0.1
            self.registButton.alpha = 0.1

        }) 
    }
    //实时监测text的变化来确定bool值
    fileprivate func textValueGuard() {
        self.phoneTextFiled.addTarget(self, action: #selector(RegistViewController.textValueChange(_:)), for: UIControlEvents.editingChanged)
        self.passwordTextFiled.addTarget(self, action: #selector(RegistViewController.textValueChange(_:)), for: UIControlEvents.editingChanged)
        self.verifyText.addTarget(self, action: #selector(RegistViewController.textValueChange(_:)), for: UIControlEvents.editingChanged)
    }
    @objc fileprivate func textValueChange(_ textField:KaedeTextField) {
        self.sendVerifyButton.isEnabled = isAbleSend!
        self.registButton.isEnabled = isAbleRegist!
    }
    
    
    func backImageClick() {
        view.endEditing(true)
    }
    //清除打字内容
    fileprivate func clearInput() {
        self.phoneTextFiled.text = nil
        self.passwordTextFiled.text = nil
        self.verifyText.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        textValueGuard()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.phoneTextFiled.resignFirstResponder()
        self.passwordTextFiled.resignFirstResponder()
        self.verifyText.resignFirstResponder()
        appearAnimation()
        clearInput()
        self.sendVerifyButton.setTitle("发送验证码", for: UIControlState())
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
