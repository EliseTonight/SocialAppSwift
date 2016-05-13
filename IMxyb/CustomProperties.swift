//
//  CustomProperties.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
//公共属性

public let AppWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
public let AppHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
public let AppSize:CGRect = UIScreen.mainScreen().bounds
public let NavigationHeight:CGFloat = 64




public let RefreshImage_Height: CGFloat = 40
public let RefreshImage_Width: CGFloat = 35

/// cache文件路径
public let cachesPath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
public let SD_UserIconData_Path = cachesPath + "/iconImage.data"



