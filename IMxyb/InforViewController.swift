//
//  InforViewController.swift
//  IMxyb
//
//  Created by Elise on 16/4/16.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class InforViewController: UIViewController{
    
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var signView: UIView!
    @IBOutlet weak var signLabel: UILabel!
    
    private var iconView: IconView?
    
    private lazy var iconActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    //imagehuoqu
    private lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    private lazy var meViewController:MeViewController? = {
        let meViewController = MeViewController()
        return meViewController
    }()
    private var userSave = currentUser()
    //根据手机（唯一key）信息初始化
    var model:String? {
        didSet {
            selectedInforWithPhoneNumber()
        }
    }
    //当前用户的Id
    var id:String?
    
    //通过电话的设置来提取信息
    private func selectedInforWithPhoneNumber() {
//        let query = AVQuery(className: "_User")
//        query.whereKey("mobilePhoneNumber", equalTo: UserPhone)
//        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
//            self.phoneLabel.text = UserPhone
//            self.id = object.objectForKey("objectId") as? String
//            self.emailLabel.text = object.objectForKey("email") as? String
//            self.signLabel.text = object.objectForKey("sign") as? String
//            self.nameLabel.text = object.objectForKey("username") as? String
            
//            let gender = ""
//            if gender == "" || gender == "Secret" {
//                self.genderLabel.text = "Secret"
//            }
//            else {
//                self.genderLabel.text = gender
//            }
//            self.userSave
//            self.userSave.phoneNumber = UserPhone
//            self.userSave.email = object.objectForKey("email") as? String
//            self.userSave.sign = object.objectForKey("sign") as? String
//            self.userSave.userName = object.objectForKey("username") as? String
//
//        }
    }
    
    
    
    //注销
    @IBAction func logoutButtonClick(sender: UIButton) {
//        AVUser.logOut()
        UserPhone = nil
        UserId = nil
        self.navigationController?.popViewControllerAnimated(true)
    }


    //设置所有View的target
    private func setViewsTap() {
        setViewTap(headView, action: "headViewClick")
        setViewTap(nameView, action: "nameViewClick")
        setViewTap(emailView, action: "emailViewClick")
        setViewTap(signView, action: "signViewClick")
        setViewTap(genderView, action: "genderViewClick")
        
    }
    //设置单个View的target
    private func setViewTap(view:UIView?,action:Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view?.userInteractionEnabled = true
        view?.addGestureRecognizer(tap)
    }
    //设置头部头像
    @objc private func headViewClick() {
        iconActionSheet.showInView(view)
    }
    //设置名字
    private var nameViewChange:NPEViewController? = {
        let nameViewChange = NPEViewController()
        return nameViewChange
    }()
    @objc private func nameViewClick() {
        if self.signLabel.text == nil {
            nameViewChange?.nameCurrent = ""
        }
        else {
            nameViewChange?.nameCurrent = self.nameLabel.text!
        }
        nameViewChange?.id = "Lily"
        self.navigationController?.pushViewController(nameViewChange!, animated: true)
    }
    //设置签名
    private lazy var signViewChange:SignViewController? = {
        let signViewChange = SignViewController()
        return signViewChange
    }()
    @objc private func signViewClick() {
        if self.signLabel.text == nil {
            signViewChange?.signCurrent = ""
        }
        else {
            signViewChange?.signCurrent = self.signLabel.text!
        }
        signViewChange?.id = "A civilization is gone with wind"
        self.navigationController?.pushViewController(signViewChange!, animated: true)
    }
    private lazy var genderVC:GenderViewController? = {
        let genVC = GenderViewController()
        return genVC
    }()
    //设置性别
    @objc private func genderViewClick() {
        if self.genderLabel.text == nil {
            genderVC?.currentGender = "Secret"
        }
        else {
            genderVC?.currentGender = self.genderLabel.text!
        }
        self.navigationController?.pushViewController(genderVC!, animated: true)
    }
    //设置邮箱
    @objc private func emailViewClick() {
        
    }
 
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "InforView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsTap()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedInforWithPhoneNumber()
        SVProgressHUD.dismiss()
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
/// MARK: UIActionSheetDelegate
extension InforViewController: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex, terminator: "")
        switch buttonIndex {
        case 1:
            openCamera()
        case 2:
            openUserPhotoLibrary()
        default:
            print("", terminator: "")
        }
    }
    
}
/// MARK: 摄像机和相册的操作和代理方法
extension InforViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 打开照相功能
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            pickVC.sourceType = .Camera
            self.presentViewController(pickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showErrorWithStatus("模拟器没有摄像头,请链接真机调试", maskType: SVProgressHUDMaskType.Black)
        }
    }
    
    /// 打开相册
    private func openUserPhotoLibrary() {
        pickVC.sourceType = .PhotoLibrary
        pickVC.allowsEditing = true
        presentViewController(pickVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 对用户选着的图片进行质量压缩,上传服务器,本地持久化存储
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data: NSData?
//                    let smallImage = UIImage.imageClipToNewImage(image, newSize: headImage!.size)
//                    if UIImagePNGRepresentation(smallImage) == nil {
//                        data = UIImageJPEGRepresentation(smallImage, 0.8)
//                    } else {
//                        data = UIImagePNGRepresentation(smallImage)
//                    }
//                    
                    if data != nil {
//                        do {
//                            // TODO: 将头像的data传入服务器
//                            // 本地也保留一份data数据
//                            try NSFileManager.defaultManager().createDirectoryAtPath(cachesPath, withIntermediateDirectories: true, attributes: nil)
//                        } catch _ {
//                        }
//                        NSFileManager.defaultManager().createFileAtPath(SD_UserIconData_Path, contents: data, attributes: nil)
//                        
//                        iconView!.iconButton.setImage(UIImage(data: NSData(contentsOfFile: SD_UserIconData_Path)!)!.imageClipOvalImage(), forState: .Normal)
//
                    } else {
                        SVProgressHUD.showErrorWithStatus("照片保存失败", maskType: SVProgressHUDMaskType.Black)
                    }
                }
            }
        } else {
            SVProgressHUD.showErrorWithStatus("图片无法获取", maskType: SVProgressHUDMaskType.Black)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        pickVC.dismissViewControllerAnimated(true, completion: nil)
    }
}
