//
//  NPEViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class NPEViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView! {
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: "cancelEdit")
            backView.addGestureRecognizer(tap)
            backView.userInteractionEnabled = true
        }
    }
    @objc private func cancelEdit() {
        self.view.endEditing(true)
    }
    
    
    
    
    @IBOutlet weak var clearButton: UIButton!
    var nameCurrent:String = ""
    var id = ""
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.text = nameCurrent
            if textField.text == "" {
                self.clearButton.hidden = true
            }
        }
    }
    //实时监测text的变化来确定bool值
    private func textValueGuard() {
        self.textField.addTarget(self, action: "textValueChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    @objc private func textValueChange(text:UITextField) {
        if text.text == "" {
            self.clearButton.hidden = true
        }
        else {
            self.clearButton.hidden = false
        }
    }
    @IBAction func clearButtonClick(sender: UIButton) {
        self.textField.text = ""
    }

    
    //右边的保存
    private func setRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonClick")
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.greenColor()], forState: UIControlState.Normal)
    }
    //保存按钮
    @objc private func saveButtonClick() {
//        let object = AVObject(withoutDataWithClassName: "_User", objectId: self.id)
//        object.setObject(self.textField.text, forKey: "username")
//        SVProgressHUD.show()
//        object.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                SVProgressHUD.showSuccessWithStatus("修改成功")
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else {
//                SVProgressHUD.showErrorWithStatus("操作失败")
//            }
//        }
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "NPEViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightButton()
        textValueGuard()
        self.navigationItem.title = "名字"
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
