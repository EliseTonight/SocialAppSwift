//
//  SignViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/25.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    
    
    
    var signCurrent:String = ""
    var id = ""

    
    
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var textView: UITextView!{
        didSet {
            textView.text = signCurrent
        }
    }
    
    @IBAction func clearButtonClick(sender: UIButton) {
        textView.text = ""
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "SignViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //右边的保存
    private func setRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonClick")
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.greenColor()], forState: UIControlState.Normal)
    }
    //保存按钮
    @objc private func saveButtonClick() {
//        let object = AVObject(withoutDataWithClassName: "_User", objectId: self.id)
//        object.setObject(self.textView.text, forKey: "sign")
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

    
    
    
    
    
    
    
    override func viewDidLoad() {
     

        super.viewDidLoad()
        setRightButton()
        self.navigationItem.title = "个性签名"
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
