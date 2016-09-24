//
//  UserModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation


public var User = AVUser()
///当前用户的唯一手机号
public var UserPhone:String?
///当前用户的唯一Id
public var UserId:String?
///当前用户的唯一名字
public var UserName:String?
///当前用户的唯一头像
public var UserIcon:String?
///当前用户的唯一粉丝数
public var UserFans:String?
///当前用户的唯一关注数
public var UserStars:String?



open class OCPublicProperty:NSObject {
    var userP = UserPhone
    var userI = UserId
    
    class func getData() -> String? {
        return UserPhone
    }
    fileprivate static let instance = OCPublicProperty()
    
    class func getUserP() -> String? {
        return UserPhone
    }
}
open class appPro:NSObject {

    
    class func getW() -> CGFloat? {
        return AppWidth
    }
    class func getH() -> CGFloat? {
        return AppHeight
    }
}


open class userDataBase:NSObject {
    
}




class currentUser {
    ///用户名
    var userName:String?
    ///手机号
    var phoneNumber:String?
    ///邮箱
    var email:String?
    ///签名
    var sign:String?
    ///头像
    var headImage:String?
    ///粉丝数
    var fans:String?
    ///关注数
    var stars:String?
}
