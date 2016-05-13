//
//  UIView+.swift
//  IMxyb
//
//  Created by Elise on 16/4/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

extension UIView {
    func setViewTap(action:Selector,controller:UIViewController) {
        let tap = UITapGestureRecognizer(target: controller, action: action)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func setViewTap(action:Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
}