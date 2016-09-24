//
//  DefaultView.swift
//  IMxyb
//
//  Created by Elise on 16/4/25.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class DefaultView: UIView {
    @IBOutlet weak var backImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "changeToMeView")
            backImage.isUserInteractionEnabled = true
            backImage.addGestureRecognizer(tap)
        }
    }
    

    @IBOutlet weak var backImage2: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "changeToMeView")
            backImage2.isUserInteractionEnabled = true
            backImage2.addGestureRecognizer(tap)
        }
    }
    
    var delegate:DefaultViewDelegate?
    
    @objc fileprivate func changeToMeView() {
        delegate?.defaultViewTapDelegate()
    }
    

    
    
    
    
    
    
    
    
    
    
    
    class func defaultViewFromXib() -> DefaultView {
        let view = Bundle.main.loadNibNamed("DefaultView", owner: nil, options: nil)?.last as? DefaultView
        return view!
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    


}
protocol DefaultViewDelegate {
    func defaultViewTapDelegate()
}

