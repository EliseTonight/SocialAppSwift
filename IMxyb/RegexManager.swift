//
//  RegexManager.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation


//正则表达式自定义工具
public class RegExManager {
    
    private static let instance = RegExManager()
    /// 全局统一访问入口
    public class var sharedManager: RegExManager {
        return instance
    }
    ///需要匹配的数据与匹配表达式
    public func getResultWithRegExStr(input:String?,pattern:String) -> Bool {
        
        let regex:NSRegularExpression?
        regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let matchs = regex?.matchesInString(input!, options: [], range: NSMakeRange(0, input!.characters.count))
        return matchs?.count > 0
        
    }
    
    
    //
}


struct RegExStrList {
    let regExPhoneStr = "^[0-9]{11}$"
    let regExPasswordStr = "^[a-z0-9A-Z]{6,25}$"
    let regExEmailStr = "[A-Z0-9a-z._%+-] + @[A-Za-z0-9.-] + \\.[A-Za-z]{2,6}"
    let regExNameStr = "^.{1,15}$"
    let regExVerifyCodeStr = "^[0-9]{6}$"
    
}