//
//  PopViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/24.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    
    @IBOutlet weak var multiplyChat: UIView!
    @IBOutlet weak var addFriendView: UIView!
    @IBOutlet weak var QRCodeView: UIView! {
        didSet {
            QRCodeView.setViewTap("QRCodeViewClick", controller: self)
        }
    }
    
    
    
    @objc fileprivate func QRCodeViewClick() {
        self.openCamera()
    }
    
    
    
    
    
    //imagehuoqu
    fileprivate lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PopViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
extension PopViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 打开照相功能
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickVC.sourceType = .camera
            self.present(pickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "模拟器没有摄像头,请链接真机调试", maskType: SVProgressHUDMaskType.black)
            
        }
    }
}
