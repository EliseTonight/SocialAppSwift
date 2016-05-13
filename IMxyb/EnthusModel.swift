//
//  EnthusModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation



class EnthusModel:NSObject {
    ///标题（or标题）
    var title:String?
    ///喜欢数
    var likers_count:String?
    ///内容url
    var uri:String?
    ///评论数
    var comment_count:String?
    ///副标题（or地址）
    var desc:String?
    ///作者名（or，主标题）
    var name:String?
    ///头像url
    var avatar:String?
    ///右侧图像,即主要图像
    var cover_url:String?
    ///类型
    var type:String?
    ///多个图片
    var more_pic_urls:[String]?
    ///图片总数
    var photos_count:String?
    
}
class EnthusModels:NSObject,DictModelProtocol {
    ///models
    var recommend_feeds:[EnthusModel]?
    var new_recommend_count_str:String?
    var date:String?
    
    
    class func loadMeiTianMixModels(completion:(data:EnthusModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("enthusdataRow", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: EnthusModels.self) as? EnthusModels
            completion(data: finalData, error: nil)
        }
    }

    
    
    static func customClassMapping() -> [String : String]? {
        return ["recommend_feeds":"\(EnthusModel.self)"]
    }
}