//
//  ProModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/26.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
class ProModels:NSObject,DictModelProtocol {
    ///models
    var recommend_feeds:[EnthusModel]?
    var new_recommend_count_str:String?
    var date:String?
    
    
    class func loadProModels(completion:(data:ProModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("proDataRow", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: ProModels.self) as? ProModels
            completion(data: finalData, error: nil)
        }
    }
    
    
    
    static func customClassMapping() -> [String : String]? {
        return ["recommend_feeds":"\(EnthusModel.self)"]
    }
}