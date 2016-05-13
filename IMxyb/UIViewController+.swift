//
//  UIViewController+.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

extension UIViewController {
    func setButton(button:UIButton,frame:CGRect,image:String,highImage:String,selectedImage:String?,action:Selector) {
        button.frame = frame
        button.setImage(UIImage(named: image), forState: UIControlState.Normal)
        button.setImage(UIImage(named: highImage), forState: UIControlState.Highlighted)
        if selectedImage != nil {
            button.setImage(UIImage(named: selectedImage!), forState: UIControlState.Selected)
        }
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
}