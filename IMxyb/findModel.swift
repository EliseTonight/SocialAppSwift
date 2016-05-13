//
//  findModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

let FindNameArray:[String] = ["团子~","Fear","SOB","Summer","Winter","Why should I","柳如舟","赵蒙蒙","短章","卞之琳","Deemo","VK克","雨蔬","秋石","Cersi","Stark","Tyrion Lannister"]

class FindModel:NSObject {
    ///头像
    var headImage:String?
    ///名字
    var name:String?
}

class FindModels:NSObject {
    ///所有数据
    var allFindAbleData:[FindModel] = []
    
    
    //生成不重复头像
    private var iconCopy = IconArray
    private var nameCopy = FindNameArray
    
    ///初始化生成数据
    internal func initAllFindAbleData(num:Int) {
        
        for i in 0..<num {
            self.iconCopy = IconArray
            self.nameCopy = FindNameArray
            let singleFind = FindModel()
            //生成头像，不可以重复,生成名字
            let currentNum = Int(arc4random() % UInt32(iconCopy.count))
            let remove = self.iconCopy.removeAtIndex(currentNum)
            singleFind.headImage = remove
            let currentNameNum = Int(arc4random() % UInt32(nameCopy.count))
            let removeName = self.nameCopy.removeAtIndex(currentNum)
            singleFind.name = removeName
            self.allFindAbleData.append(singleFind)
        }

    }
    
    
}




let FindDataBase = []