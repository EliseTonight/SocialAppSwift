//
//  ImageView+.swift
//  IMxyb
//
//  Created by Elise on 16/4/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
import UIKit

import UIKit
@IBDesignable
class CornerImageView: UIImageView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidrh:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidrh
        }
    }
    @IBInspectable var borderColor:UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
//    convenience override init(image: UIImage?) {
//        self.image = image
//        self.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
}
extension UIImage {
    func scaleToFitBackgroundImageSize(_ fitSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContext(fitSize)
        self.draw(in: CGRect(x: 0, y: 0, width: fitSize.width, height: fitSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
    }
}
