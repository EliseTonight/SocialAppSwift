//
//  MeMainView.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeMainView: UIView {
    
    @IBOutlet weak var signLabel: UILabel!
    
    var delegate:MeMainViewDelegate?
    fileprivate var userLocal = currentUser()
    var model:String? {

        didSet {
            if model != nil {
                selectedInforWithPhoneNumber()
            }
            else  {
                self.headImage.image = UIImage(named: "logo_s")
                self.fansLabel.text = "0"
                self.starLabel.text = "0"
                self.nameLabel.text = "登录"
                self.topImage.image = UIImage(named: "deer")
                self.signLabel.text = "签名"
            }
        }
    }
    
    //通过电话的设置来提取信息
    fileprivate func selectedInforWithPhoneNumber() {
//        let query = AVQuery(className: "_User")
//        query.whereKey("mobilePhoneNumber", equalTo: UserPhone)
//        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
//            self.userLocal.phoneNumber = UserPhone
//            self.userLocal.email = object.objectForKey("email") as? String
//            self.userLocal.sign = object.objectForKey("sign") as? String
//            self.userLocal.userName = object.objectForKey("username") as? String
//            self.userLocal.fans = object.objectForKey("fans") as? String
//            self.userLocal.stars = object.objectForKey("stars") as? String
            if UserPhone == "15112345678" {
                self.headImage.image = UIImage(named: "head")
                self.topImage.image = UIImage(named: "thesea")
            }
            else {
                self.headImage.image = UIImage(named: "logo_s")
                self.topImage.image = UIImage(named: "deer")
            }
//            self.fansLabel.text = self.userLocal.fans
//            self.starLabel.text = self.userLocal.stars
//            self.nameLabel.text = self.userLocal.userName
//            self.signLabel.text = self.userLocal.sign
//        }
    }
    
    
    

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "headImageClick")
            nameLabel.addGestureRecognizer(tap)
        }
    }
    
    //头部图像具有点击事件
    @IBOutlet weak var headImage: CornerImageView! {
        didSet {
            headImage.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: "headImageClick")
            headImage.addGestureRecognizer(tap)
        }
    }
    @IBAction func likeButtonClick(_ sender: UIButton) {
        
    }
    @IBAction func collectionButtonClick(_ sender: UIButton) {
        
    }
    
    @IBAction func shakeButtonClick(_ sender: UIButton) {
        delegate?.shakeButtonDelegate!(sender)
    }
    

    @objc fileprivate func headImageClick() {
        delegate?.headImageDelegate()
    }
    
    
    class func meMainViewWithXib() -> MeMainView {
        let view = Bundle.main.loadNibNamed("MeMainView", owner: nil, options: nil)?.last as? MeMainView
        view?.frame.size.width = AppWidth
        return view!
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
@objc protocol MeMainViewDelegate {
    @objc optional func shakeButtonDelegate(_ sender:UIButton)
    @objc optional func consultButtonDelegate(_ sender:UIButton)
    @objc optional func likeButtonDelegate(_ sender:UIButton)
    @objc optional func collectionDelegate(_ sender:UIButton)
    func headImageDelegate()
}
