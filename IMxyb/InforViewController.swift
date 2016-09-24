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
    
    fileprivate var iconView: IconView?
    
    fileprivate lazy var iconActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    //imagehuoqu
    fileprivate lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    fileprivate lazy var meViewController:MeViewController? = {
        let meViewController = MeViewController()
        return meViewController
    }()
    fileprivate var userSave = currentUser()
    //根据手机（唯一key）信息初始化
    var model:String? {
        didSet {
            selectedInforWithPhoneNumber()
        }
    }
    //当前用户的Id
    var id:String?
    
    //通过电话的设置来提取信息
    fileprivate func selectedInforWithPhoneNumber() {
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
    @IBAction func logoutButtonClick(_ sender: UIButton) {
//        AVUser.logOut()
        UserPhone = nil
        UserId = nil
        self.navigationController?.popViewController(animated: true)
    }


    //设置所有View的target
    fileprivate func setViewsTap() {
        setViewTap(headView, action: #selector(InforViewController.headViewClick))
        setViewTap(nameView, action: #selector(InforViewController.nameViewClick))
        setViewTap(emailView, action: #selector(InforViewController.emailViewClick))
        setViewTap(signView, action: #selector(InforViewController.signViewClick))
        setViewTap(genderView, action: #selector(InforViewController.genderViewClick))
        
    }
    //设置单个View的target
    fileprivate func setViewTap(_ view:UIView?,action:Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view?.isUserInteractionEnabled = true
        view?.addGestureRecognizer(tap)
    }
    //设置头部头像
    @objc fileprivate func headViewClick() {
        iconActionSheet.show(in: view)
    }
    //设置名字
    fileprivate var nameViewChange:NPEViewController? = {
        let nameViewChange = NPEViewController()
        return nameViewChange
    }()
    @objc fileprivate func nameViewClick() {
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
    fileprivate lazy var signViewChange:SignViewController? = {
        let signViewChange = SignViewController()
        return signViewChange
    }()
    @objc fileprivate func signViewClick() {
        if self.signLabel.text == nil {
            signViewChange?.signCurrent = ""
        }
        else {
            signViewChange?.signCurrent = self.signLabel.text!
        }
        signViewChange?.id = "A civilization is gone with wind"
        self.navigationController?.pushViewController(signViewChange!, animated: true)
    }
    fileprivate lazy var genderVC:GenderViewController? = {
        let genVC = GenderViewController()
        return genVC
    }()
    //设置性别
    @objc fileprivate func genderViewClick() {
        if self.genderLabel.text == nil {
            genderVC?.currentGender = "Secret"
        }
        else {
            genderVC?.currentGender = self.genderLabel.text!
        }
        self.navigationController?.pushViewController(genderVC!, animated: true)
    }
    //设置邮箱
    @objc fileprivate func emailViewClick() {
        
    }
 
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    override func viewWillAppear(_ animated: Bool) {
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
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
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
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickVC.sourceType = .camera
            self.present(pickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "模拟器没有摄像头,请链接真机调试", maskType: SVProgressHUDMaskType.black)
        }
    }
    
    /// 打开相册
    fileprivate func openUserPhotoLibrary() {
        pickVC.sourceType = .photoLibrary
        pickVC.allowsEditing = true
        present(pickVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 对用户选着的图片进行质量压缩,上传服务器,本地持久化存储
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data: Data?
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
                        SVProgressHUD.showError(withStatus: "照片保存失败", maskType: SVProgressHUDMaskType.black)
                    }
                }
            }
        } else {
            SVProgressHUD.showError(withStatus: "图片无法获取", maskType: SVProgressHUDMaskType.black)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickVC.dismiss(animated: true, completion: nil)
    }
}
