//
//  HeadView.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HeadView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    
    
    var model:CustomCellModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.headImage.sd_setImageWithURL(NSURL(string: (model?.avatar!)!)!, placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
        }
    }
    
    
    
    
    class func headViewWithXib(frame:CGRect) -> HeadView {
        let view = NSBundle.mainBundle().loadNibNamed("HeadView", owner: nil, options: nil).last as? HeadView
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
