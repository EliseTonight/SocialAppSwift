//
//  GenderViewController.swift
//  IMxyb
//
//  Created by Elise on 16/5/6.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {

    @IBOutlet weak var maleView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "maleViewTap")
            maleView.userInteractionEnabled = true
            maleView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var femaleView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "femaleViewTap")
            femaleView.userInteractionEnabled = true
            femaleView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var secretView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "secretViewTap")
            secretView.userInteractionEnabled = true
            secretView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var maleCheckImageView: UIImageView! {
        didSet {
            maleCheckImageView.hidden = true
        }
    }
    @IBOutlet weak var femaleCheckImageView: UIImageView! {
        didSet {
            femaleCheckImageView.hidden = true
        }
    }
    @IBOutlet weak var secretCheckImageView: UIImageView! {
        didSet {
            secretCheckImageView.hidden = true
        }
    }
    
    @objc private func maleViewTap() {
//        let object = AVObject(withoutDataWithClassName: "_User", objectId: UserId)
//        object.setObject("男", forKey: "gender")
//        SVProgressHUD.show()
//        object.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.maleCheckImageView.hidden = false
                self.femaleCheckImageView.hidden = true
                self.secretCheckImageView.hidden = true
                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else {
//                SVProgressHUD.showErrorWithStatus("操作失败")
//            }
//        }
    }
    @objc private func femaleViewTap() {
//        let object = AVObject(withoutDataWithClassName: "_User", objectId: UserId)
//        object.setObject("女", forKey: "gender")
//        SVProgressHUD.show()
//        object.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.maleCheckImageView.hidden = true
                self.femaleCheckImageView.hidden = false
                self.secretCheckImageView.hidden = true
                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else {
//                SVProgressHUD.showErrorWithStatus("操作失败")
//            }
//        }
    }
    @objc private func secretViewTap() {
//        let object = AVObject(withoutDataWithClassName: "_User", objectId: UserId)
//        object.setObject("Secret", forKey: "gender")
//        SVProgressHUD.show()
//        object.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.maleCheckImageView.hidden = true
                self.femaleCheckImageView.hidden = true
                self.secretCheckImageView.hidden = false
                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else {
//                SVProgressHUD.showErrorWithStatus("操作失败")
//            }
//        }
    }
    //接受的性别
    var currentGender:String = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "GenderViewController", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initCheckOut() {
        if self.currentGender == "女" {
            self.maleCheckImageView.hidden = true
            self.femaleCheckImageView.hidden = false
            self.secretCheckImageView.hidden = true
        }
        else if self.currentGender == "男" {
            self.maleCheckImageView.hidden = false
            self.femaleCheckImageView.hidden = true
            self.secretCheckImageView.hidden = true
        }
        else {
            self.maleCheckImageView.hidden = true
            self.femaleCheckImageView.hidden = true
            self.secretCheckImageView.hidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCheckOut()

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
