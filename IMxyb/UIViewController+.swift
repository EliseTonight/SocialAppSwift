//
//  UIViewController+.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

extension UIViewController {
    func setButton(_ button:UIButton,frame:CGRect,image:String,highImage:String,selectedImage:String?,action:Selector) {
        button.frame = frame
        button.setImage(UIImage(named: image), for: UIControlState())
        button.setImage(UIImage(named: highImage), for: UIControlState.highlighted)
        if selectedImage != nil {
            button.setImage(UIImage(named: selectedImage!), for: UIControlState.selected)
        }
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
}
