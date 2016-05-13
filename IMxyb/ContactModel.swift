//
//  ContactModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation



class ContactModel:NSObject {
    ///名字
    var name:String?
    ///头像
    var image:String?
    
    
    func getName() -> String? {
        return self.name
    }
    
}

class ContactModels:NSObject {
    ///所有通讯录人
    var contacts:[ContactModel] = []
    
    func initMemberWithNum(num:Int) {
        
        let firstNames = ["赵","钱","孙","李","周","吴","郑","王","冯","陈","楚","卫","蒋","沈","韩","杨","徐","马","张","言","梅","虞","习","江","朱","任","陆","艾","柏","毕","白","孔","欧"]
        let secondNames = ["大","美","帅","应","超","海","江","湖","春","夏","秋","冬","上","左","有","纯","希","霖","泽","莉"]
        let thirdNames = ["强","好","领","亮","超","华","奎","海","工","青","红","潮","兵","垂","刚","山","名","莉"]
        for i in 0..<num {
            var singleContact = ContactModel()
            let nameR = arc4random() % UInt32(firstNames.count)
            let nameR2 = arc4random() % UInt32(secondNames.count)
            let nameTwoOrThree = arc4random() % 101
            if nameTwoOrThree > 50 {
                let nameR3 = arc4random() % UInt32(thirdNames.count)
                let name = firstNames[Int(nameR)] + secondNames[Int(nameR2)] + thirdNames[Int(nameR3)]
                singleContact.name = name
            }
            else {
                let name = firstNames[Int(nameR)] + secondNames[Int(nameR2)]
                singleContact.name = name
            }
            let rand = Int(arc4random() % UInt32(IconArray.count))
            let imageName = IconArray[rand]
            singleContact.image = imageName
            self.contacts.append(singleContact)
        }
    }
    func deleteDate() {
        self.contacts.removeAll()
    }
}