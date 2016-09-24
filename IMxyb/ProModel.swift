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
    
    
    class func loadProModels(_ completion:(_ data:ProModels?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "proDataRow", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: ProModels.self) as? ProModels
            completion(finalData, nil)
        }
    }
    
    
    
    static func customClassMapping() -> [String : String]? {
        return ["recommend_feeds":"\(EnthusModel.self)"]
    }
}
