//
//  AnotherInfoTopView.swift
//  IMxyb
//
//  Created by Elise on 16/4/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AnotherInfoTopView: UIView {
    
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starNumLabel: UILabel!
    @IBOutlet weak var fansNumLabel: UILabel!
    
    
    
    
    var model:MessageModel? {
        didSet {
            self.headImage.image = UIImage(named: (model?.icon)!)
            self.nameLabel.text = model?.youName
            self.starNumLabel.text = "0"
            self.fansNumLabel.text = "0"
        }
    }
    
    
    
    
    
    
    
    
    
    class func anotherInfoTopViewFromXib(frame:CGRect) -> AnotherInfoTopView {
        let view = NSBundle.mainBundle().loadNibNamed("AnotherInfoTopView", owner: nil, options: nil).last as? AnotherInfoTopView
        view?.frame = frame
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
