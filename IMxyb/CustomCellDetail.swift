//
//  CustomCellDetail.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation


class CommentModel:NSObject {
    ///头像
    var head:String?
    ///名字
    var name:String?
    ///内容
    var text:String?
}

class CustomCellModel:NSObject ,DictModelProtocol{
    ///title
    var title:String?
    ///描述
    var abstract:String?
    ///web内容
    var content:String?
    ///评论
    var comment:[CommentModel]?
    ///名字 
    var name:String?
    ///头像
    var avatar:String?
    
    
    class func loadCustomCellModel(_ completion:(_ data:CustomCellModel?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "OneCellDetail", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let tool = DictModelManager.sharedManager
            let object = tool.objectWithDictionary(dict!, cls: CustomCellModel.self) as? CustomCellModel
            completion(object, nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["comment":"\(CommentModel.self)"]
    }
}
