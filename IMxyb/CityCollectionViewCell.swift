//
//  CityCollectionViewCell.swift
//  LittleDay
//
//  Created by Elise on 16/3/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
//城市的Cell
class CityCollectionViewCell: UICollectionViewCell {
    private var label:UILabel = UILabel()
    
    var cityName:String? {
        didSet {
            self.label.text = cityName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = UIColor.blackColor()
        label.highlightedTextColor = UIColor.redColor()
        label.backgroundColor = UIColor.whiteColor()
        label.textAlignment = .Center
        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //override子控件布局
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
}