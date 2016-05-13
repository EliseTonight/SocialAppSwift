//
//  CustomCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enthuseTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rightView: UIImageView!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    
    var model:EnthusModel? {
        didSet {
            self.headImage.sd_setImageWithURL(NSURL(string: (model?.avatar)!), placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
            self.enthuseTypeLabel.text = model?.type
            self.titleLabel.text = model?.title
            if model?.comment_count == nil {
                self.commentLabel.text = "0"
            }
            else {
                self.commentLabel.text = model?.comment_count
            }
            if model?.likers_count == nil {
                self.likeNumLabel.text = "0"
            }
            else {
                self.likeNumLabel.text = model?.likers_count
            }
            //判断是否存在图片
            self.rightView.sd_setImageWithURL(NSURL(string: (model?.cover_url)!), placeholderImage: UIImage(named: "quesheng"))
        }
    }
    
    
    
    
    
    
    
    
    class func customCellWithXib(tableView:UITableView) -> CustomCell {
        let id = "customCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? CustomCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CustomCell", owner: nil, options: nil).last as? CustomCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
